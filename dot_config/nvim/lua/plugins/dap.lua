return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "LiadOz/nvim-dap-repl-highlights",
    },
    config = function()
      vim.fn.sign_define("DapBreakpoint", {
        text = "・",
        texthl = "DapBreakpoint",
        linehl = "DapBreakpoint",
        numhl = "DapBreakpoint",
      })
      require("dapui").setup()
    end,
    keys = {
      {
        "<F12>",
        function() require("dapui").toggle() end,
        mode = "n",
        desc = "DAP: Toggle UI",
      },
      {
        "<leader>bc",
        function() require("dap").continue() end,
        mode = "n",
        desc = "DAP: Continue / Start",
      },
      {
        "<leader>bp",
        function() require("dap").toggle_breakpoint() end,
        mode = "n",
        desc = "DAP: Toggle breakpoint",
      },
      {
        "<leader>bo",
        function() require("dap").step_over() end,
        mode = "n",
        desc = "DAP: Step over",
      },
      {
        "<leader>bi",
        function() require("dap").step_into() end,
        mode = "n",
        desc = "DAP: Step into",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "python" },
      handlers = {},
    },
  },
}
