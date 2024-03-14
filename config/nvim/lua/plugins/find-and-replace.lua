return {
  -- global find/replace
  {
    'windwp/nvim-spectre',
    keys = {
      {
        '<leader>sst',
        function()
          require('spectre').toggle()
        end,
        desc = 'Toggle',
      },
      {
        '<leader>sss',
        function()
          require('spectre').open()
        end,
        desc = 'Search in files',
      },
      {
        '<leader>ssw',
        function()
          require('spectre').open { select_word = true }
        end,
        desc = 'Search in files for word under cursor',
      },
      {
        '<leader>ssf',
        function()
          require('spectre').open_file_search { select_word = true }
        end,
        desc = 'Search in current file',
      },
    },
    config = function()
      require('spectre').setup {
        is_open_target_win = false,
        is_insert_mode = true,
        is_close = true,
      }
    end,
  },
}
