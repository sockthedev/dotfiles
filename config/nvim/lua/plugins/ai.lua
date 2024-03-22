return {
  {
    'zbirenbaum/copilot.lua',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    cmd = 'Copilot',
    event = 'VimEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = '<M-CR>',
            accept_word = '<M-Right>',
            accept_line = '<M-Down>',
            prev = '<M-[>',
            next = '<M-]>',
            dismiss = '<C-]>',
          },
        },
        panel = {
          auto_refresh = false,
          keymap = {
            accept = '<CR>',
            jump_prev = '<M-[>',
            jump_next = '<M-]>',
            refresh = 'gr',
            open = '<M-CR>',
          },
        },
      }
    end,
  },

  {
    'robitx/gp.nvim',
    config = function()
      require('gp').setup {
        chat_topic_gen_model = 'gpt-4-turbo-preview',
        openai_api_key = { 'cat', '/Users/sock/.openai_api_key' },
      }

      vim.keymap.set('n', '<leader>as', '<cmd>GpChatSend<cr>', { desc = '[A]I [S]end' })
      vim.keymap.set('n', '<leader>ar', '<cmd>GpChatReply<cr>', { desc = '[A]I [R]eply' })
      vim.keymap.set('n', '<leader>ac', '<cmd>GpChatClear<cr>', { desc = '[A]I [C]lear' })
      vim.keymap.set('n', '<leader>ad', '<cmd>GpChatDelete<cr>', { desc = '[A]I [D]elete' })
      vim.keymap.set('n', '<leader>al', '<cmd>GpChatList<cr>', { desc = '[A]I [L]ist' })
      -- vim.keymap.set('n', '<leader>at', '<cmd>GpChatTopic<cr>', { desc = '[A]I [T]opic' })
      vim.keymap.set('n', '<leader>ap', '<cmd>GpChatPrompt<cr>', { desc = '[A]I [P]rompt' })
      vim.keymap.set('n', '<leader>an', '<cmd>GpChatNew<cr>', { desc = '[A]I [N]ew' })
      vim.keymap.set('n', '<leader>ah', '<cmd>GpChatFinder<cr>', { desc = '[A]I [H]istory' })
      vim.keymap.set('n', '<leader>at', '<cmd>GpChatToggle vsplit<cr>', { desc = '[A]I [T]oggle' })
    end,
  },
}
