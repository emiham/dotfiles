return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mfussenegger/nvim-jdtls",
      {
        "williamboman/mason.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
      },
      "saghen/blink.cmp",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          -- stylua: ignore start
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: Go to declaration", unpack(opts) })

          vim.keymap.set("n", "gd", function()
            require("telescope.builtin").lsp_definitions({ reuse_win = true })
          end, { desc = "LSP: Go to definition", unpack(opts) })

          vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover documentation", unpack(opts) })

          vim.keymap.set("n", "gi", function()
            require("telescope.builtin").lsp_implementations({ reuse_win = true })
          end, { desc = "LSP: Go to implementation", unpack(opts) })

          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature help", unpack(opts) })

          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "LSP: Add workspace folder", unpack(opts) })

          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "LSP: Remove workspace folder", unpack(opts) })

          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { desc = "LSP: List workspace folders", unpack(opts) })

          vim.keymap.set("n", "<leader>D", function()
            require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
          end, { desc = "LSP: Go to type definition", unpack(opts) })

          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename symbol", unpack(opts) })

          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code action", unpack(opts) })

          vim.keymap.set("n", "gr", function()
            require("telescope.builtin").lsp_references({ reuse_win = true })
          end, { desc = "LSP: Find references", unpack(opts) })

          vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, { desc = "LSP: Format buffer", unpack(opts) })

          vim.keymap.set("n", "<leader>ci", function() require("telescope.builtin").lsp_incoming_calls({ reuse_win = true }) end, { desc = "LSP: Incoming Calls", unpack(opts) })
          vim.keymap.set("n", "<leader>lh", function()
              if vim.lsp.inlay_hint.is_enabled() then
                vim.lsp.inlay_hint.enable(false, nil)
              else
                vim.lsp.inlay_hint.enable(true, nil)
              end
          end, { desc = "Toggle type hints", unpack(opts) })
          -- stylua: ignore end
        end,
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local lsps = {
        {
          "ruff",
          {
            capabilities = (function()
              local c = vim.deepcopy(capabilities)
              c.hoverProvider = false
              return c
            end)(),
            settings = {
              python = {
                analysis = {
                  typeCheckingMode = "off",
                },
              },
            },
          },
        },
        {
          "basedpyright",
          {
            settings = {
              basedpyright = {
                analysis = {
                  typeCheckingMode = "standard",
                  ignore = { "*" },
                  autoSearchPaths = true,
                  diagnosticMode = "openFilesOnly",
                  useLibraryCodeForTypes = true,
                },
                disableOrganizeImports = true,
              },
            },
          },
        },
        { "jdtls" },
        {
          "sqlls",
          {
            settings = {
              sqlls = {
                connections = {
                  {
                    driver = "postgresql",
                    dataSourceName = "host=127.0.0.1 port=5432 user=emil dbname=dbas sslmode=disable",
                  },
                },
              },
            },
          },
        },
        {
          "clangd",
          settings = {
            clangd = {
              InlayHints = {
                Designators = true,
                Enabled = true,
                ParameterNames = true,
                DeducedTypes = true,
              },
              fallbackFlags = { "-std=c++20" },
            },
          },
        },
        {
          "bashls",
          {
            settings = vim.fn.expand("%:t") == ".env"
                and { bashIde = { shellcheckArguments = "-e SC2034" } }
              or {},
          },
        },
        { "texlab" },
        { "yamlls" },
        {
          "hls",
          {
            filetypes = { "haskell", "lhaskell", "cabal" },
            settings = {
              haskell = {
                formattingProvider = "fourmolu",
              },
            },
          },
        },
        { "taplo" },
        { "rust_analyzer" },
        {
          "lua_ls",
          {
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
                hint = {
                  enable = true,
                },
              },
            },
          },
        },
        { "typescript-language-server" },
        {
          "harper_ls",
          {
            filetypes = string.find(vim.fn.expand("%:p"), "docs")
                and { "text", "gitcommit", "markdown", "typst" }
              or {},
            settings = {
              ["harper-ls"] = {
                userDictPath = vim.fn.stdpath("config")
                  .. "/spell/en.utf-8.add",
              },
            },
            on_attach = function(_, _) vim.opt_local.spell = false end,
          },
        },
        {
          "ltex_plus",
          {
            filetypes = string.find(vim.fn.expand("%:p"), "docs") and require(
              "lspconfig.configs.ltex_plus"
            ).default_config.filetypes or {},
            settings = {
              ltex = {
                language = "auto",
              },
            },
          },
        },
      }

      for _, lsp in pairs(lsps) do
        local name, config = lsp[1], lsp[2]

        vim.lsp.enable(name)

        if config then
          if not config.capabilities then
            config.capabilities = capabilities
          end
          vim.lsp.config(name, config)
        else
          capabilities = capabilities
        end
      end

      -- TODO Split (or stop using?)
      require("mason-tool-installer").setup({
        ensure_installed = {
          "ruff",
          "basedpyright",
          "jdtls",
          "sqlls",
          "clangd",
          "bash-language-server", -- bashls
          "texlab",
          "yaml-language-server", -- yamlls
          "haskell-language-server", -- hls
          "taplo",
          "rust-analyzer", -- rust_analyzer
          "lua-language-server", -- lua_ls
          "typescript-language-server",
          "harper-ls",
          "ltex-ls-plus",
          "awk-language-server",
          "stylua",
          "prettierd",
          "eslint_d",
          "rustfmt",
          "google-java-format",
          "jq",
          "latexindent",
          "clang-format",
          "beautysh",
          "debugpy",
          "kdlfmt",
        },
      })
    end,
  },
}
