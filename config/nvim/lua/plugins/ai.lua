return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "Copilot",
    event = "VimEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<M-CR>",
            accept_word = "<M-Right>",
            accept_line = "<M-Down>",
            prev = "<M-[>",
            next = "<M-]>",
            dismiss = "<C-]>",
          },
        },
        panel = {
          auto_refresh = false,
          keymap = {
            accept = "<CR>",
            jump_prev = "<M-[>",
            jump_next = "<M-]>",
            refresh = "gr",
            open = "<M-CR>",
          },
        },
      })
    end,
  },

  {
    "Bryley/neoai.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    cmd = {
      "NeoAI",
      "NeoAIOpen",
      "NeoAIClose",
      "NeoAIToggle",
      "NeoAIContext",
      "NeoAIContextOpen",
      "NeoAIContextClose",
      "NeoAIInject",
      "NeoAIInjectCode",
      "NeoAIInjectContext",
      "NeoAIInjectContextCode",
      "NeoAIShortcut",
    },
    keys = {
      { "<leader>ar", desc = "Rewrite text", mode = "v" },
      { "<leader>ag", desc = "Generate git commit message", mode = "n" },
      { "<leader>at", desc = "Toggle", mode = "n" },
      { "<leader>aq", desc = "Close", mode = "n" },
      { "<leader>ao", desc = "Open with context", mode = { "n", "v" } },
    },
    config = function()
      vim.keymap.set("n", "<leader>at", "<cmd>NeoAIToggle<CR>", { desc = "Toggle" })
      vim.keymap.set("n", "<leader>aq", "<cmd>NeoAIClose<CR>", { desc = "Close" })
      vim.keymap.set({ "n", "v" }, "<leader>ao", "<cmd>NeoAIContext<CR>", { desc = "Open with context" })

      require("neoai").setup({
        ui = {
          output_popup_text = "OpenAI",
          input_popup_text = "Prompt",
          width = 40, -- percentage
          output_popup_height = 80, -- percentage
        },
        models = {
          {
            name = "openai",
            model = "gpt-4",
            params = nil,
          },
        },
        inject = {
          cutoff_width = 99999,
        },
        shortcuts = {
          {
            name = "rewrite",
            key = "<leader>ar",
            desc = "Rewrite text",
            use_context = true,
            prompt = [[
                    Please rewrite the text to make it more readable, clear,
                    concise, and fix any grammatical, punctuation, or spelling
                    errors
                ]],
            modes = { "v" },
            strip_function = nil,
          },
          {
            name = "commit",
            key = "<leader>ag",
            desc = "Generate git commit message",
            use_context = false,
            prompt = function()
              return [[
                        Using the following git diff generate a consise and
                        clear git commit message, with a short title summary
                        that is 75 characters or less:
                    ]] .. vim.fn.system("git diff --cached")
            end,
            modes = { "n" },
            strip_function = nil,
          },
        },
      })
    end,
  },
}
