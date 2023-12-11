local plugins = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/schemastore.nvim",
      "folke/neodev.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "MunifTanjim/prettier.nvim",
      "onsails/lspkind-nvim",
      { "j-hui/fidget.nvim" },
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
          "williamboman/mason.nvim",
          cmd = "Mason",
          config = {
            ui = { border = "rounded" },
          },
          opts = {
            ensure_installed = {
              "debugpy",
            },
          },
        },
      },
    },
    event = "BufReadPre",
    config = function()
      require("plugins.lsp.base")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "jay-babu/mason-null-ls.nvim",
    },
    event = "BufReadPre",
    config = function()
      require("plugins.lsp.null-ls")
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("plugins.lsp.lspsaga")
    end,
  },
}

return plugins
