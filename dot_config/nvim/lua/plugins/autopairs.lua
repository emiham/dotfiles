return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  init = function()
    local Rule = require("nvim-autopairs.rule")
    local npairs = require("nvim-autopairs")
    local cond = require("nvim-autopairs.conds")

    npairs.add_rules({
      Rule(" ", " ")
        :with_pair(cond.after_text("}"))
        :with_pair(cond.before_text("{")),
    })
  end,
  config = true,
}
