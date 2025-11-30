return {
  {
    'folke/sidekick.nvim',
    opts = {
      cli = {
        mux = {
          enabled = false,
          backend = 'zellij',
        },
        tools = {
          opencode = {
            cmd = { 'opencode' },
            env = { OPENCODE_THEME = 'system' },
            -- opencode uses <c-p> for its own functionality, so we override the default
            keys = { prompt = { '<c-,>', 'prompt' } },
          },
        },
      },
      nes = {
        enabled = false,
      },
    },
    keys = {
      -- {
      --   '<tab>',
      --   function()
      --     -- if there is a next edit, jump to it, otherwise apply it if any
      --     if not require('sidekick').nes_jump_or_apply() then
      --       return '<Tab>' -- fallback to normal tab
      --     end
      --   end,
      --   expr = true,
      --   desc = 'Goto/Apply Next Edit Suggestion',
      -- },
      {
        '<c-.>',
        function()
          require('sidekick.cli').toggle()
        end,
        desc = 'Sidekick Toggle',
        mode = { 'n', 't', 'i', 'x' },
      },
      {
        '<c-,>',
        function()
          require('sidekick.cli').prompt()
        end,
        desc = 'Select Prompt',
        mode = { 'n', 'x' },
      },
      {
        '<leader>aa',
        function()
          require('sidekick.cli').toggle()
        end,
        desc = 'Sidekick Toggle CLI',
      },
      {
        '<leader>as',
        function()
          require('sidekick.cli').select()
        end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = 'Select CLI',
      },
      {
        '<leader>ad',
        function()
          require('sidekick.cli').close()
        end,
        desc = 'Detach a CLI Session',
      },
      {
        '<leader>at',
        function()
          require('sidekick.cli').send { msg = '{this}' }
        end,
        mode = { 'x', 'n' },
        desc = 'Send This',
      },
      {
        '<leader>af',
        function()
          require('sidekick.cli').send { msg = '{file}' }
        end,
        desc = 'Send File',
      },
      {
        '<leader>av',
        function()
          require('sidekick.cli').send { msg = '{selection}' }
        end,
        mode = { 'x' },
        desc = 'Send Visual Selection',
      },
      {
        '<leader>at',
        function()
          require('sidekick.cli').toggle { name = 'opencode', focus = true }
        end,
        desc = 'Toggle OpenCode',
      },
    },
  },

  -- {
  --   'zbirenbaum/copilot.lua',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --   },
  --   cmd = 'Copilot',
  --   event = 'VimEnter',
  --   config = function()
  --     require('copilot').setup {
  --       suggestion = {
  --         enabled = true,
  --         auto_trigger = true,
  --         hide_during_completion = true,
  --         debounce = 75,
  --         trigger_on_accept = true,
  --         keymap = {
  --           accept = '<C-]>',
  --           accept_word = false,
  --           accept_line = false,
  --           next = '<M-]>',
  --           prev = '<M-[>',
  --           dismiss = '<C-[>',
  --         },
  --       },
  --     }
  --   end,
  -- },
}
