return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      local snacks = require 'snacks'

      snacks.setup {
        bufdelete = {},
        -- bigfile adds a new filetype bigfile to Neovim that triggers when the file is larger than the configured size. This automatically prevents things like LSP and Treesitter attaching to the buffer.
        bigfile = {
          notify = true,
          size = 1.5 * 1024 * 1024, -- 1.5MB
        },
        image = {},
        -- input = {
        --   border = 'single',
        --   height = 3,
        -- },
        lazygit = {
          theme = {
            selectedLineBgColor = { bg = 'default' },
          },
        },
        words = {
          notify_end = false,
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
      vim.keymap.set('n', '<C-f>', function()
        snacks.words.jump(1, true)
      end, { desc = 'jump [f]orward word' })
      vim.keymap.set('n', '<C-b>', function()
        snacks.words.jump(-1, true)
      end, { desc = 'jump [b]ackwards word' })

      vim.keymap.set('n', '<leader>bo', function()
        snacks.bufdelete.other()
      end, { desc = 'close [o]ther' })
      vim.keymap.set('n', '<leader>ba', function()
        snacks.bufdelete.all()
      end, { desc = 'close [a]ll' })
      vim.keymap.set('n', '<leader>bc', function()
        snacks.bufdelete.delete()
      end, { desc = 'close [c]urrent' })
    end,
  },
}
