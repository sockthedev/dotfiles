return {
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
        styles = {
          italic = false,
          transparency = true,
        },
      }
      vim.cmd 'colorscheme rose-pine'
    end,
  },
}
