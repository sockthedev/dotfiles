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
      vim.cmd.colorscheme 'lackluster-mint' -- types are green
    end,
  },

  -- funky cursor travel animation
  {
    'sphamba/smear-cursor.nvim',
    opts = {
      cursor_color = '#ffffff',
      stiffness = 0.8, -- 0.6      [0, 1]
      trailing_stiffness = 0.5, -- 0.3      [0, 1]
      distance_stop_animating = 0.5, -- 0.1      > 0
      hide_target_hack = false, -- true     boolean
    },
  },

  -- nice ui elements
  {
    'stevearc/dressing.nvim',
    opts = {
      input = {
        enabled = false,
      },
      select = {
        enabled = true,
      },
    },
  },
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
}
