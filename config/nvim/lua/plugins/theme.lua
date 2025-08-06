return {
  {
    'folke/noice.nvim',
    opts = {
      cmdline = {
        enabled = false,
      },
      lsp = {
        progress = {
          enabled = false,
        },
        -- hover = {
        --   enabled = false,
        -- },
        -- signature = {
        --   enabled = false,
        -- },
      },
      messages = {
        enabled = false,
      },
      notify = {
        enabled = false,
      },
      presets = {
        lsp_doc_border = true,
      },
    },
  },

  -- theme
  {
    'slugbyte/lackluster.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      local lackluster = require 'lackluster'
      -- local background = '#191919'
      local background = '#000000'
      lackluster.setup {
        tweak_color = {
          green = lackluster.color.lack,
        },
        tweak_syntax = {
          comment = lackluster.color.gray5,
        },
        tweak_background = {
          normal = background,
          telescope = background,
          menu = background, -- nvim_cmp, wildmenu
          popup = background, -- lazy, mason, whichkey
        },
      }
      -- vim.cmd.colorscheme 'lackluster-mint' -- types are green
    end,
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        dim_inactive_windows = false,
        extend_background_behind_borders = false,
        styles = {
          bold = true,
          italic = false,
          transparency = true,
        },
        -- highlight_groups = {
        --   FloatBorder = { fg = '#cccccc', blend = 20, inherit = true },
        -- },
      }
      vim.cmd 'colorscheme rose-pine'
    end,
  },

  {
    'shaunsingh/nord.nvim',
    config = function()
      -- vim.g.nord_contrast = false
      vim.g.nord_borders = true
      vim.g.nord_disable_background = true
      vim.g.nord_italic = false
      vim.g.nord_bold = false
      -- vim.g.nord_uniform_diff_background = true
    end,
  },
}
