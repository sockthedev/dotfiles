return {
  -- icons
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      local lackluster = require 'lackluster'
      require('nvim-web-devicons').setup {
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true,
        strict = true,
        color_icons = false,
        override = {
          ['default_icon'] = {
            color = lackluster.color.gray4,
            name = 'Default',
          },
        },
      }
    end,
  },

  -- theme
  {
    'slugbyte/lackluster.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      local lackluster = require 'lackluster'
      lackluster.setup {
        tweak_syntax = {
          comment = lackluster.color.gray5,
        },
        tweak_background = {
          normal = '#191919',
          telescope = '#191919',
          menu = '#191919', -- nvim_cmp, wildmenu
          popup = '#191919', -- lazy, mason, whichkey
        },
      }
      vim.cmd.colorscheme 'lackluster-mint' -- types are green
    end,
  },
}
