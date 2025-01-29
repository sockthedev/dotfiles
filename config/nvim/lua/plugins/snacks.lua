return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      local snacks = require 'snacks'

      snacks.setup {
        -- bigfile adds a new filetype bigfile to Neovim that triggers when the file is larger than the configured size. This automatically prevents things like LSP and Treesitter attaching to the buffer.
        bigfile = {
          notify = true,
          size = 1.5 * 1024 * 1024, -- 1.5MB
        },
        input = {
          border = 'single',
          height = 3,
        },
        lazygit = {
          theme = {
            selectedLineBgColor = { bg = 'default' },
          },
        },
      }

      vim.keymap.set('n', '<leader>gg', function()
        snacks.lazygit.open()
      end, { desc = 'lazy[g]it' })
      vim.keymap.set('n', '<leader>gf', function()
        snacks.lazygit.log_file()
      end, { desc = '[f]ile log' })
      vim.keymap.set('n', '<leader>gl', function()
        snacks.lazygit.log()
      end, { desc = '[l]og' })
    end,
  },
}
