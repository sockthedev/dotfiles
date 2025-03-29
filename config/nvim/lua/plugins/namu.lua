return {
  'bassamsdata/namu.nvim',
  config = function()
    require('namu').setup {
      -- Enable the modules you want
      namu_symbols = {
        enable = true,
        options = {}, -- here you can configure namu
      },
      -- Optional: Enable other modules if needed
      ui_select = { enable = false }, -- vim.ui.select() wrapper
      preview = {
        highlight_on_move = false,
        highlight_mode = 'select',
      },
      colorscheme = {
        enable = true,
        options = {
          persist = true,
          write_shada = false,
        },
      },
      highlight = 'NamuPreview',
    }

    vim.keymap.set('n', '<leader>,', ':Namu symbols<cr>', {
      desc = 'Jump to LSP symbol',
      silent = true,
    })
  end,
}
