return {
  {
    'wasabeef/yank-for-claude.nvim',
    config = function()
      require('yank-for-claude').setup()
    end,
    keys = {
      -- Reference only
      {
        '<leader>y',
        function()
          require('yank-for-claude').yank_visual()
        end,
        mode = 'v',
        desc = 'Yank for Claude',
      },
      {
        '<leader>y',
        function()
          require('yank-for-claude').yank_line()
        end,
        mode = 'n',
        desc = 'Yank line for Claude',
      },

      -- Reference + Code
      {
        '<leader>Y',
        function()
          require('yank-for-claude').yank_visual_with_content()
        end,
        mode = 'v',
        desc = 'Yank with content',
      },
      {
        '<leader>Y',
        function()
          require('yank-for-claude').yank_line_with_content()
        end,
        mode = 'n',
        desc = 'Yank line with content',
      },
    },
  },

  {
    'folke/sidekick.nvim',
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = 'zellij',
          enabled = false,
        },
      },
      tools = {
        opencode = {
          cmd = { 'opencode' },
          -- -- HACK: https://github.com/sst/opencode/issues/445
          -- env = { OPENCODE_THEME = 'system' },
          url = 'https://github.com/sst/opencode',
        },
      },
    },
    keys = {
      {
        '<tab>',
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require('sidekick').nes_jump_or_apply() then
            return '<Tab>' -- fallback to normal tab
          end
        end,
        expr = true,
        desc = 'Goto/Apply Next Edit Suggestion',
      },
      {
        '<c-.>',
        function()
          require('sidekick.cli').focus()
        end,
        mode = { 'n', 'x', 'i', 't' },
        desc = 'Sidekick Switch Focus',
      },
      {
        '<leader>aa',
        function()
          require('sidekick.cli').toggle { focus = true }
        end,
        desc = 'Sidekick Toggle CLI',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ao',
        function()
          require('sidekick.cli').toggle { name = 'opencode', focus = true }
        end,
        desc = 'Sidekick opencode Toggle',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ap',
        function()
          require('sidekick.cli').select_prompt()
        end,
        desc = 'Sidekick Ask Prompt',
        mode = { 'n', 'v' },
      },
    },
  },

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
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          trigger_on_accept = true,
          keymap = {
            accept = '<M-l>',
            accept_word = false,
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
      }
    end,
  },
}
