return {
  -- global find/replace
  {
    'windwp/nvim-spectre',
    config = function()
      require('spectre').setup {
        is_open_target_win = false,
        is_close = true,
      }

      vim.keymap.set(
        'n',
        '<leader>sss',
        "<cmd>lua require('spectre').open({ is_insert_mode = true })<cr>",
        { desc = 'Search in files' }
      )

      vim.keymap.set(
        'n',
        '<leader>ssr',
        "<cmd>lua require('spectre').open({select_word=true})<cr>",
        { desc = 'Replace current word in files' }
      )
      vim.keymap.set(
        'v',
        '<leader>ssr',
        "<cmd>lua require('spectre').open({select_word=true})<cr>",
        { desc = 'Replace current word in files' }
      )

      vim.keymap.set(
        'n',
        '<leader>ssb',
        "<cmd>lua require('spectre').open_file_search({ is_insert_mode = true })<cr>",
        { desc = 'Search in current file' }
      )
      vim.keymap.set(
        'n',
        '<leader>ssw',
        "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>",
        { desc = 'Replace current word in current file' }
      )
    end,
  },
}
