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
}
