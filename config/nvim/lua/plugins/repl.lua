return {
  -- repl
  {
    'michaelb/sniprun',
    branch = 'master',
    build = 'sh install.sh',
    config = function()
      require('sniprun').setup {
        selected_interpreters = { 'JS_TS_bun', 'Go_original' },
        display = {
          'Terminal',
        },
        live_mode_toggle = 'off',
        live_display = { 'Terminal' },
      }

      -- We wrap the call to SnipRun in a function that saves the cursor position
      function run_sniprun_against_buffer()
        local save_cursor = vim.api.nvim_win_get_cursor(0)
        vim.cmd '%SnipRun'
        vim.api.nvim_win_set_cursor(0, save_cursor)
      end

      vim.api.nvim_set_keymap(
        'n',
        '<C-T><C-T>',
        '<Cmd>lua run_sniprun_against_buffer()<CR>',
        { noremap = true, silent = true, desc = 'SnipRun [T]rigger' }
      )
      vim.api.nvim_set_keymap(
        'n',
        '<C-T><C-L>',
        '<cmd>:SnipRun<CR>',
        { noremap = true, silent = true, desc = 'SnipRun Trigger [L]ine' }
      )
      vim.api.nvim_set_keymap(
        'n',
        '<C-T><C-C>',
        '<cmd>:SnipReset<CR>',
        { noremap = true, silent = true, desc = 'SnipRun [C]lear' }
      )
      vim.api.nvim_set_keymap(
        'n',
        '<C-T><C-E>',
        '<cmd>:SnipClose<CR>',
        { noremap = true, silent = true, desc = 'SnipRun [E]xit' }
      )
      vim.api.nvim_set_keymap(
        'v',
        '<C-T><C-T>',
        "<cmd>'<,'>SnipRun<CR>",
        { noremap = true, silent = true, desc = 'SnipRun [T]rigger' }
      )
    end,
  },
}
