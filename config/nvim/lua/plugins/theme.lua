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

  -- tint inactive
  -- WARN: Keep this inline with the wezterm config
  {
    'levouh/tint.nvim',
    config = function()
      require('tint').setup {
        tint = -30,
        saturation = 1,
      }
    end,
  },

  -- theme
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
        commentStyle = { italic = false, bold = true },
        functionStyle = { italic = false, bold = true },
        keywordStyle = { italic = false, bold = true },
        statementStyle = { italic = false, bold = true },
        typeStyle = { italic = false, bold = true },
        colors = {
          theme = {},
          palette = {
            dragonViolet = '#727169',
          },
        }, -- override default palette and theme colors
        overrides = function(colors)
          local theme = colors.theme
          local background = '#000000'
          local foreground_dim = '#333333'
          local highlight = '#c4b28a'
          local mega_highlight = '#DB2777'
          return {
            LineNr = { fg = foreground_dim },
            NormalFloat = { bg = background },
            FloatBorder = { bg = background, fg = theme.ui.fg },
            WinSeparator = { fg = foreground_dim },
            BufferLineSeparator = { fg = foreground_dim },
            VertSplit = { fg = foreground_dim },
            FloatTitle = { bg = background },
            UfoFoldedBg = { bg = 'none' },
            UfoFoldedFg = { fg = 'none' },
            UfoCursorFoldedLine = { fg = 'none' },
            Folded = { fg = 'none', bg = 'none' },
            UfoFoldedMoreMsg = { fg = mega_highlight },
            LazyNormal = { bg = background, fg = theme.ui.fg },
            MasonNormal = { bg = background, fg = theme.ui.fg },
            WhichKeyBorder = { bg = background, fg = theme.ui.fg },
            WhichKeyNormal = { bg = background, fg = theme.ui.fg },
            TelescopeNormal = { bg = background, fg = theme.ui.fg },
            TelescopeBorder = { bg = background, fg = theme.ui.fg },
            TelescopePromptNormal = { bg = background, fg = theme.ui.fg },
            TelescopePromptBorder = { bg = background, fg = theme.ui.fg },
            TelescopePromptTitle = { bg = background, fg = theme.ui.fg },
            TelescopePreviewBorder = { bg = background, fg = theme.ui.fg },
            TelescopePreviewNormal = { bg = background, fg = theme.ui.fg },
            TelescopePreviewTitle = { bg = background, fg = theme.ui.fg },
            TelescopeResultsTitle = { bg = background, fg = theme.ui.fg },
            TelescopeResultsNormal = { bg = background, fg = theme.ui.fg },
            TelescopeResultsBorder = { bg = background, fg = theme.ui.fg },
            MiniStatuslineDevinfo = { bg = background, fg = foreground_dim },
            MiniStatuslineFileinfo = { bg = background, fg = foreground_dim },
            MiniStatuslineFilename = { bg = background, fg = foreground_dim },
            MiniStatuslineInactive = { bg = background, fg = foreground_dim },
            NeoTreeDimTexta = { fg = foreground_dim },
            NeoTreeFileName = { fg = theme.ui.fg },
            -- NeoTreeDotfile = { fg = 'none' },
            -- NeoTreeDimText = { fg = 'none' },
            NeoTreeDirectoryName = { fg = highlight },
            NeoTreeRootName = { fg = highlight },
          }
        end,
      }

      -- setup must be called before loading
      vim.cmd 'colorscheme kanagawa-paper'
    end,
  },
}
