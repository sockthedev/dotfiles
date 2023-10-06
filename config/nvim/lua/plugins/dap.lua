return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    lazy = true,
    keys = {
      {
        "<Leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Breakpoint",
      },
      {
        "<Leader>dB",
        function()
          ---@diagnostic disable-next-line: param-type-mismatch
          local condition = vim.fn.input("Breakpoint condition: ")
          ---@diagnostic disable-next-line: param-type-mismatch
          local hit_condition = vim.fn.input("Breakpoint hit condition: ")
          ---@diagnostic disable-next-line: param-type-mismatch
          local log_message = vim.fn.input("Breakpoint log message: ")
          require("dap").set_breakpoint(condition, hit_condition, log_message)
        end,
        desc = "Conditional Breakpoint",
      },
      {
        "<Leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<Leader>dp",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },
      {
        "<Leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<Leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<Leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<Leader>dO",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<Leader>drc",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<Leader>drp",
        function()
          require("dap-python").test_method()
        end,
        desc = "Run Python Method",
      },
      {
        "<Leader>dh",
        function()
          ---@diagnostic disable-next-line: missing-parameter
          require("dapui").eval()
        end,
        desc = "Eval",
      },
    },
    config = function()
      local dap = require("dap")
      local dap_ui = require("dapui")
      local dap_vt = require("nvim-dap-virtual-text")

      dap_ui.setup()

      dap_vt.setup({
        enabled = true,
        enable_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = false,
        all_references = false,
        filter_references_pattern = "<module",
        virt_text_pos = "eol",
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      })

      dap.listeners.after.event_initialized["dapui_config"] = function()
        ---@diagnostic disable-next-line: missing-parameter
        dap_ui.open()
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        ---@diagnostic disable-next-line: missing-parameter
        dap_ui.close()
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        ---@diagnostic disable-next-line: missing-parameter
        dap_ui.close()
      end

      require("plugins.dap.javascript")
    end,
  },
  {
    "jayp0521/mason-nvim-dap.nvim",
    config = function()
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        ensure_installed = { "node2", "chrome" },
      })
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
  },
}
