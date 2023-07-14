return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "marilari88/neotest-vitest",
    "haydenmeade/neotest-jest",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vitest"),
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
      },
      quickfix = {
        enabled = false,
      },
    })

    vim.keymap.set("n", "<leader>tt", function()
      require("neotest").run.run()
    end, { desc = "Run nearest test" })

    vim.keymap.set("n", "<leader>tf", function()
      require("neotest").run.run(vim.fn.expand("%"))
    end, { desc = "Run current file" })

    vim.keymap.set("n", "<leader>td", function()
      require("neotest").run.run({ strategy = "dap" })
    end, { desc = "Debug nearest test" })

    vim.keymap.set("n", "<leader>ts", function()
      require("neotest").run.stop()
    end, { desc = "Stop nearest test" })

    vim.keymap.set("n", "<leader>ta", function()
      require("neotest").run.attach()
    end, { desc = "Attach to nearest test" })

    vim.keymap.set("n", "<leader>tp", function()
      require("neotest").run.run_last()
    end, { desc = "Run previous test" })

    vim.keymap.set("n", "<leader>to", function()
      require("neotest").output.open()
    end, { desc = "Run previous test" })
  end,
}
