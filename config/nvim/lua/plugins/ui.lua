return {
  -- icons
  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        -- your personnal icons can go here (to override)
        -- DevIcon will be appended to `name`
        override = {},
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true,
      })
    end,
  },

  -- Zen mode editing
  {
    "folke/zen-mode.nvim",
    keys = {
      {
        "<leader>Z",
        function()
          require("zen-mode").toggle()
        end,
        desc = "Toggle Zen Mode",
      },
    },
    config = function()
      require("zen-mode").setup({
        window = {
          backdrop = 1,
          options = {
            signcolumn = "no",
            list = false,
            foldcolumn = "0",
            cursorline = false,
          },
        },
        plugins = {
          gitsigns = { enabled = false },
        },
      })
    end,
  },

  -- displays colors inline (hex, etc)
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = {
        "css",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        html = { mode = "foreground" },
      },
      user_default_options = {
        tailwind = true,
      },
    },
  },
}
