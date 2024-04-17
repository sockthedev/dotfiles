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
            name = 'CodeGPT4',
            chat = false,
            command = true,
            model = { model = 'gpt-4-turbo', temperature = 0.8, top_p = 1 },
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
          desc = desc,
        }
      end

      -- Chat commands
      vim.keymap.set({ 'n', 'i' }, '<C-g>cn', '<cmd>GpChatNew<cr>', keymapOptions '[N]ew')
      vim.keymap.set({ 'n', 'i' }, '<C-g>ct', '<cmd>GpChatToggle<cr>', keymapOptions '[T]oggle')
      vim.keymap.set({ 'n', 'i' }, '<C-g>cf', '<cmd>GpChatFinder<cr>', keymapOptions '[F]inder')

      vim.keymap.set({ 'n', 'i' }, '<C-g>ch', '<cmd>GpChatNew split<cr>', keymapOptions '[H]orizontal split')
      vim.keymap.set({ 'n', 'i' }, '<C-g>cv', '<cmd>GpChatNew vsplit<cr>', keymapOptions '[V]ertical split')

      vim.keymap.set('v', '<C-g>ch', ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions '[H]orizontal split')
      vim.keymap.set('v', '<C-g>cv', ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions '[V]ertical split')

      -- Prompt commands
      vim.keymap.set({ 'n', 'i' }, '<C-g>ir', '<cmd>GpRewrite<cr>', keymapOptions '[R]ewrite')
      vim.keymap.set({ 'n', 'i' }, '<C-g>ia', '<cmd>GpAppend<cr>', keymapOptions '[A]ppend')
      vim.keymap.set({ 'n', 'i' }, '<C-g>ip', '<cmd>GpPrepend<cr>', keymapOptions '[P]repend')

      vim.keymap.set('v', '<C-g>ir', ":<C-u>'<,'>GpRewrite<cr>", keymapOptions '[R]ewrite')
      vim.keymap.set('v', '<C-g>ia', ":<C-u>'<,'>GpAppend<cr>", keymapOptions '[A]ppend')
      vim.keymap.set('v', '<C-g>ip', ":<C-u>'<,'>GpPrepend<cr>", keymapOptions '[P]repend')
      vim.keymap.set('v', '<C-g>ii', ":<C-u>'<,'>GpImplement<cr>", keymapOptions '[I]mplement')

      vim.keymap.set({ 'n', 'i' }, '<C-g>x', '<cmd>GpContext<cr>', keymapOptions 'Conte[X]t')
      vim.keymap.set('v', '<C-g>x', ":<C-u>'<,'>GpContext<cr>", keymapOptions 'Conte[X]t')

      vim.keymap.set({ 'n', 'i', 'v', 'x' }, '<C-g>s', '<cmd>GpStop<cr>', keymapOptions '[S]top')
      vim.keymap.set({ 'n', 'i', 'v', 'x' }, '<C-g>n', '<cmd>GpNextAgent<cr>', keymapOptions '[N]ext Agent')
    end,
  },
}
