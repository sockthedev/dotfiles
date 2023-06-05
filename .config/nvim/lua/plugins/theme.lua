return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1,
    config = function()
      require("kanagawa").setup({
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = {
            -- change specific usages for a certain theme, or for all of them
            wave = {
              ui = {
                float = {
                  -- bg = "none",
                },
              },
            },
            dragon = {
              ui = {
                float = {
                  -- bg = "none",
                },
              },
              syn = {
                parameter = "yellow",
              },
            },
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
        overrides = function(colors) -- add/modify highlights
          local theme = colors.theme
          return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            TelescopeBorder = { bg = "none" },
            Folded = { bg = "none" },
            TabLineFill = { bg = "none" },
            HarpoonNumberInactive = { bg = "none" },
            HarpoonInactive = { bg = "none" },
            HarpoonActive = { bg = "none" },
            HarpoonNumberActive = { bg = "none" },
          }
        end,
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus",
        },
      })
      vim.cmd.colorscheme("kanagawa-wave")
    end,
  },
}
