return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        style = 'night',
        styles = {
          sidebars = 'transparent',
          floats = 'transparent',
        },
        on_highlights = function(hl, c)
          -- local prompt = c.bg_dark
          local prompt = nil
          hl.TelescopeNormal = {
            bg = prompt,
            fg = c.fg_dark,
          }
          hl.TelescopeBorder = {
            bg = prompt,
            fg = prompt,
          }
          hl.TelescopePromptNormal = {
            bg = prompt,
          }
          hl.TelescopePromptBorder = {
            bg = prompt,
            fg = prompt,
          }
          hl.TelescopePromptTitle = {
            bg = prompt,
            fg = prompt,
          }
          hl.TelescopePreviewTitle = {
            bg = prompt,
            fg = prompt,
          }
          hl.TelescopeResultsTitle = {
            bg = prompt,
            fg = prompt,
          }
        end,
      }
      -- vim.cmd [[
      --   colorscheme tokyonight-night
      --   echo " "
      -- ]]
    end,
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      require('rose-pine').setup {
        disable_background = true,
        styles = {
          italic = false,
          transparency = true,
        },
      }

      vim.cmd 'colorscheme rose-pine'
    end,
  },
}
