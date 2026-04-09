# https://github.com/pazz/alot/wiki/Contrib-Hooks#open-html-emails-in-external-browser

import os
import re
import subprocess
import tempfile
from datetime import datetime
from urllib.request import urlopen

from alot.commands.globals import PromptCommand


def pre_buffer_focus(ui, dbm, buf):
    if buf.modename == "search":
        buf.rebuild()


def _preview_attachments(emails):
    directory = tempfile.TemporaryDirectory(prefix="alot-", suffix="-attachments")

    for email in emails:
        for part in email.walk():
            # multipart/* are just containers
            if part.get_content_maintype() == "multipart":
                continue
            filename = part.get_filename()
            if filename:
                with open(
                    os.path.join(directory.name, os.path.basename(filename)), "wb"
                ) as fp:
                    fp.write(part.get_payload(decode=True))

    # fzf is interactive, capture_output doesn't work out of the box
    resultfile = tempfile.NamedTemporaryFile(mode="w", suffix="fzf", prefix="alot-")
    with open(resultfile.name, "w") as outfile:
        result = subprocess.run(
            [
                "fzf",
                "--preview",
                "fzf-preview.sh {}",
                "--preview-window",
                "up,80%",
            ],
            cwd=directory.name,
            stdout=outfile,
        )

    if result.returncode == 0:
        with open(resultfile.name) as f:
            for line in f:
                filename = line.rstrip("\n")
                subprocess.run(["xdg-open", os.path.join(directory.name, filename)])
    resultfile.close()


def preview_attachments(ui=None):
    if not ui:
        return

    ui.notify("Listing attachments…")
    if ui.current_buffer.modename == "thread":
        messages = [ui.current_buffer.get_selected_message()]
    elif ui.current_buffer.modename == "search":
        messages = ui.current_buffer.get_selected_thread().get_messages()
    else:
        return

    emails = [msg.get_email() for msg in messages]
    _preview_attachments(emails)


def github_mark_read(ui):
    if "notifications@github.com" in ui.current_buffer.envelope.get_all("From")[0]:
        msg = ui.current_buffer.get_selected_message()
        msgtext = str(msg.get_email())
        r = r"img src='(https://github.com/notifications/beacon/.*.gif)'"
        beacons = re.findall(r, msgtext)
        if beacons:
            urlopen(beacons[0])
            ui.notify("removed from github notifications:\n %s" % beacons[0])


def unsubscribe(ui):
    """
    Unsubscribe from a mailing list.

    This hook reads the 'List-Unsubscribe' header of a mail in thread mode,
    constructs a unsubsribe-mail according to any mailto-url it finds
    and opens the new mail in an envelope buffer.
    """
    from alot.buffers import EnvelopeBuffer
    from alot.helper import mailto_to_envelope

    msg = ui.current_buffer.get_selected_message()
    e = msg.get_email()
    uheader = e["List-Unsubscribe"]
    dtheader = e.get("Delivered-To", None)

    if uheader is not None:
        M = re.search(r"<(mailto:\S*?)>", uheader)
        if M is not None:
            env = mailto_to_envelope(M.group(1))
            if dtheader is not None:
                env["From"] = dtheader
            ui.buffer_open(EnvelopeBuffer(ui, env))
    else:
        ui.notify("focused mail contains no 'List-Unsubscribe' header", "error")


async def schedule(ui):
    get_selected_item = getattr(
        ui.current_buffer,
        {"search": "get_selected_thread", "thread": "get_selected_message"}[ui.mode],
    )
    item = get_selected_item()
    if not item:
        return
    tags = []
    for tag in item.get_tags():
        if " " in tag:
            tags.append('"%s"' % tag)
        # skip empty tags
        elif tag:
            tags.append(tag)

    send_time = datetime.now().strftime("sendat-%Y-%m-%d-%H-%M")
    initial_tagstring = ",".join(sorted(tags)) + "," + send_time
    r = await ui.apply_command(PromptCommand("retag " + initial_tagstring))
    return r
