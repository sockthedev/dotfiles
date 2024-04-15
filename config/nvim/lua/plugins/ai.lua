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
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    config = function()
      require('CopilotChat').setup {
        debug = true, -- Enable debugging
        -- See Configuration section for rest
      }
    end,
  },

  {
    'robitx/gp.nvim',
    config = function()
      require('gp').setup {
        chat_topic_gen_model = 'gpt-4-turbo-preview',
        openai_api_key = { 'cat', '/Users/sock/.openai_api_key' },
        -- default command agents (model + persona)
        -- name, model and system_prompt are mandatory fields
        -- to use agent for chat set chat = true, for command set command = true
        -- to remove some default agent completely set it just with the name like:
        -- agents = {  { name = "ChatGPT4" }, ... },
        agents = {
          {
            name = 'ChatGPT4',
            chat = true,
            command = false,
            model = { model = 'gpt-4-turbo', temperature = 1.1, top_p = 1 },
            system_prompt = 'You are a general AI assistant.\n\n'
              .. 'The user provided the additional info about how they would like you to respond:\n\n'
              .. "- If you're unsure don't guess and say you don't know instead.\n"
              .. '- Ask question if you need clarification to provide better answer.\n'
              .. '- Think deeply and carefully from first principles step by step.\n'
              .. '- Zoom out first to see the big picture and then zoom in to details.\n'
              .. '- Use Socratic method to improve your thinking and coding skills.\n'
              .. "- Don't elide any code from your output if the answer requires coding.\n"
              .. "- Take a deep breath; You've got this!\n",
          },
          {
            name = 'ChatGPT3-5',
            chat = true,
            command = false,
            model = { model = 'gpt-3.5-turbo', temperature = 1.1, top_p = 1 },
            system_prompt = 'You are a general AI assistant.\n\n'
              .. 'The user provided the additional info about how they would like you to respond:\n\n'
              .. "- If you're unsure don't guess and say you don't know instead.\n"
              .. '- Ask question if you need clarification to provide better answer.\n'
              .. '- Think deeply and carefully from first principles step by step.\n'
              .. '- Zoom out first to see the big picture and then zoom in to details.\n'
              .. '- Use Socratic method to improve your thinking and coding skills.\n'
              .. "- Don't elide any code from your output if the answer requires coding.\n"
              .. "- Take a deep breath; You've got this!\n",
          },
          {
            name = 'CodeGPT4',
            chat = false,
            command = true,
            model = { model = 'gpt-4-turbo', temperature = 0.8, top_p = 1 },
            system_prompt = 'You are an AI working as a code editor.\n\n'
              .. 'Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n'
              .. 'START AND END YOUR ANSWER WITH:\n\n```',
          },
          {
            name = 'CodeGPT3-5',
            chat = false,
            command = true,
            model = { model = 'gpt-3.5-turbo', temperature = 0.8, top_p = 1 },
            system_prompt = 'You are an AI working as a code editor.\n\n'
              .. 'Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n'
              .. 'START AND END YOUR ANSWER WITH:\n\n```',
          },
        },
      }

      local function keymapOptions(desc)
        return {
          noremap = true,
          silent = true,
          nowait = true,
          desc = '[GPT] ' .. desc,
        }
      end

      -- Chat commands
      vim.keymap.set({ 'n', 'i' }, '<C-g>c', '<cmd>GpChatNew<cr>', keymapOptions 'New Chat')
      vim.keymap.set({ 'n', 'i' }, '<C-g>t', '<cmd>GpChatToggle<cr>', keymapOptions 'Toggle Chat')
      vim.keymap.set({ 'n', 'i' }, '<C-g>f', '<cmd>GpChatFinder<cr>', keymapOptions 'Chat Finder')

      vim.keymap.set('v', '<C-g>c', ":<C-u>'<,'>GpChatNew<cr>", keymapOptions 'Visual Chat New')
      vim.keymap.set('v', '<C-g>p', ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions 'Visual Chat Paste')
      vim.keymap.set('v', '<C-g>t', ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions 'Visual Toggle Chat')

      vim.keymap.set({ 'n', 'i' }, '<C-g><C-x>', '<cmd>GpChatNew split<cr>', keymapOptions 'New Chat split')
      vim.keymap.set({ 'n', 'i' }, '<C-g><C-v>', '<cmd>GpChatNew vsplit<cr>', keymapOptions 'New Chat vsplit')
      vim.keymap.set({ 'n', 'i' }, '<C-g><C-t>', '<cmd>GpChatNew tabnew<cr>', keymapOptions 'New Chat tabnew')

      vim.keymap.set('v', '<C-g><C-x>', ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions 'Visual Chat New split')
      vim.keymap.set('v', '<C-g><C-v>', ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions 'Visual Chat New vsplit')
      vim.keymap.set('v', '<C-g><C-t>', ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions 'Visual Chat New tabnew')

      -- Prompt commands
      vim.keymap.set({ 'n', 'i' }, '<C-g>r', '<cmd>GpRewrite<cr>', keymapOptions 'Inline Rewrite')
      vim.keymap.set({ 'n', 'i' }, '<C-g>a', '<cmd>GpAppend<cr>', keymapOptions 'Append (after)')
      vim.keymap.set({ 'n', 'i' }, '<C-g>b', '<cmd>GpPrepend<cr>', keymapOptions 'Prepend (before)')

      vim.keymap.set('v', '<C-g>r', ":<C-u>'<,'>GpRewrite<cr>", keymapOptions 'Visual Rewrite')
      vim.keymap.set('v', '<C-g>a', ":<C-u>'<,'>GpAppend<cr>", keymapOptions 'Visual Append (after)')
      vim.keymap.set('v', '<C-g>b', ":<C-u>'<,'>GpPrepend<cr>", keymapOptions 'Visual Prepend (before)')
      vim.keymap.set('v', '<C-g>i', ":<C-u>'<,'>GpImplement<cr>", keymapOptions 'Implement selection')

      vim.keymap.set({ 'n', 'i' }, '<C-g>gp', '<cmd>GpPopup<cr>', keymapOptions 'Popup')
      vim.keymap.set({ 'n', 'i' }, '<C-g>ge', '<cmd>GpEnew<cr>', keymapOptions 'GpEnew')
      vim.keymap.set({ 'n', 'i' }, '<C-g>gn', '<cmd>GpNew<cr>', keymapOptions 'GpNew')
      vim.keymap.set({ 'n', 'i' }, '<C-g>gv', '<cmd>GpVnew<cr>', keymapOptions 'GpVnew')
      vim.keymap.set({ 'n', 'i' }, '<C-g>gt', '<cmd>GpTabnew<cr>', keymapOptions 'GpTabnew')

      vim.keymap.set('v', '<C-g>gp', ":<C-u>'<,'>GpPopup<cr>", keymapOptions 'Visual Popup')
      vim.keymap.set('v', '<C-g>ge', ":<C-u>'<,'>GpEnew<cr>", keymapOptions 'Visual GpEnew')
      vim.keymap.set('v', '<C-g>gn', ":<C-u>'<,'>GpNew<cr>", keymapOptions 'Visual GpNew')
      vim.keymap.set('v', '<C-g>gv', ":<C-u>'<,'>GpVnew<cr>", keymapOptions 'Visual GpVnew')
      vim.keymap.set('v', '<C-g>gt', ":<C-u>'<,'>GpTabnew<cr>", keymapOptions 'Visual GpTabnew')

      vim.keymap.set({ 'n', 'i' }, '<C-g>x', '<cmd>GpContext<cr>', keymapOptions 'Toggle Context')
      vim.keymap.set('v', '<C-g>x', ":<C-u>'<,'>GpContext<cr>", keymapOptions 'Visual Toggle Context')

      vim.keymap.set({ 'n', 'i', 'v', 'x' }, '<C-g>s', '<cmd>GpStop<cr>', keymapOptions 'Stop')
      vim.keymap.set({ 'n', 'i', 'v', 'x' }, '<C-g>n', '<cmd>GpNextAgent<cr>', keymapOptions 'Next Agent')
    end,
  },
}
