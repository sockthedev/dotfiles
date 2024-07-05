return {
  -- icons
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup {
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true,
        color_icons = true,
        strict = true,
      }
    end,
  },

  {
    'sho-87/kanagawa-paper.nvim',
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa-paper').setup {
        undercurl = true,
        transparent = true,
        gutter = false,
        dimInactive = false,
        terminalColors = true,
        commentStyle = { italic = true },
        functionStyle = { italic = false },
        keywordStyle = { italic = false, bold = false },
        statementStyle = { italic = false, bold = false },
        typeStyle = { italic = false },
        colors = { theme = {}, palette = {} }, -- override default palette and theme colors
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = theme.ui.bg },
            FloatBorder = { bg = 'none' },
            FloatTitle = { bg = theme.ui.bg },

            -- Save a hlgroup with dark background and dimmed foreground
            -- so that you can use it where you still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg, fg = theme.ui.fg },
            MasonNormal = { bg = theme.ui.bg, fg = theme.ui.fg },
            TelescopeNormal = { bg = theme.ui.bg, fg = theme.ui.fg },
            TelescopeBorder = { bg = theme.ui.bg, fg = theme.ui.bg },
            TelescopePromptNormal = { bg = theme.ui.bg, fg = theme.ui.fg },
            TelescopePromptBorder = { bg = theme.ui.bg, fg = theme.ui.fg },
            TelescopePromptTitle = { bg = theme.ui.bg, fg = theme.ui.fg },
            TelescopePreviewTitle = { bg = theme.ui.bg, fg = theme.ui.fg },
            TelescopeResultsTitle = { bg = theme.ui.bg, fg = theme.ui.fg },
            TelescopeResultsNormal = { bg = theme.ui.bg, fg = theme.ui.fg },
            TelescopeResultsBorder = { bg = theme.ui.bg, fg = theme.ui.fg },
          }
        end,
      }

      -- setup must be called before loading
      vim.cmd 'colorscheme kanagawa-paper'
    end,
  },

  {
    'catppuccin/nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'macchiato',
        background = {
          light = 'latte',
          dark = 'macchiato',
        },
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
        term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        integrations = {
          cmp = true,
          fidget = true,
          gitsigns = true,
          harpoon = true,
          nvimtree = true,
          neotest = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
          which_key = true,
        },
      }

      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },

  {
    'folke/tokyonight.nvim',
    enabled = false,
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
    enabled = false,
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

      -- vim.cmd 'colorscheme rose-pine'
    end,
  },
}
