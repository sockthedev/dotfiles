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
    keys = {
      { '<leader>ai', '<cmd>GpChatToggle vsplit<cr>', desc = '[A]I [T]oggle' },
      { '<leader>ah', '<cmd>GpChatFinder<cr>', desc = '[A]I [H]istory' },
      { '<leader>an', '<cmd>GpChatNew<cr>', desc = '[A]I [N]ew' },
    },
    config = function()
      require('gp').setup {
        chat_topic_gen_model = 'gpt-4-turbo-preview',
        openai_api_key = { 'cat', '/Users/sock/.openai_api_key' },
      }
    end,
  },
}
