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
        -- See Configuration section for rest
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
      vim.keymap.set({ 'n', 'i' }, '<C-c>c', '<cmd>CopilotChatOpen<cr>', keymapOptions '[C]hat')
      vim.keymap.set({ 'n', 'i' }, '<C-c>t', '<cmd>CopilotChatToggle<cr>', keymapOptions '[T]oggle Chat')
      vim.keymap.set({ 'n', 'i' }, '<C-c>r', '<cmd>CopilotChatReset<cr>', keymapOptions '[R]reset')
      vim.keymap.set({ 'n', 'i' }, '<C-c>x', '<cmd>CopilotChatClose<cr>', keymapOptions 'Close [X]')

      -- Selection commands
      vim.keymap.set('v', '<C-c>c', ":<C-u>'<,'>CopilotChatCommit<cr>", keymapOptions '[C]ommit Message')
      vim.keymap.set('v', '<C-c>s', ":<C-u>'<,'>CopilotChatCommitStaged<cr>", keymapOptions 'Commit Message [S]taged')
      vim.keymap.set('v', '<C-c>e', ":<C-u>'<,'>CopilotChatExplain<cr>", keymapOptions '[E]xplain')
      vim.keymap.set('v', '<C-c>f', ":<C-u>'<,'>CopilotChatFix<cr>", keymapOptions '[F]ix')
      vim.keymap.set('v', '<C-c>x', ":<C-u>'<,'>CopilotChatFix<cr>", keymapOptions 'Fi[X] Diagnostic')
      vim.keymap.set('v', '<C-c>d', ":<C-u>'<,'>CopilotChatDocs<cr>", keymapOptions '[D]ocs')
      vim.keymap.set('v', '<C-c>r', ":<C-u>'<,'>CopilotChatReview<cr>", keymapOptions '[R]eview')
      vim.keymap.set('v', '<C-c>o', ":<C-u>'<,'>CopilotChatOptimize<cr>", keymapOptions '[O]ptimize')
      vim.keymap.set('v', '<C-c>t', ":<C-u>'<,'>CopilotChatTests<cr>", keymapOptions '[T]ests')
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
            model = { model = 'gpt-4o', temperature = 1.1, top_p = 1 },
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
            model = { model = 'gpt-4o', temperature = 0.8, top_p = 1 },
            system_prompt = 'You are an AI working as a code editor.\n\n'
              .. 'Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n'
              .. 'START AND END YOUR ANSWER WITH:\n\n```',
          },
        },
        hooks = {
          CodeExplain = function(gp, params)
            local template = 'I have the following code from {{filename}}:\n\n'
              .. '```{{filetype}}\n{{selection}}\n```\n\n'
              .. 'Please respond by explaining the code above.'
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.vnew, nil, agent.model, template, agent.system_prompt)
          end,
          CodeReview = function(gp, params)
            local template = 'I have the following code from {{filename}}:\n\n'
              .. '```{{filetype}}\n{{selection}}\n```\n\n'
              .. 'Please analyze for code smells and suggest improvements.'
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.vnew 'markdown', nil, agent.model, template, agent.system_prompt)
          end,
          UnitTests = function(gp, params)
            local template = 'I have the following code from {{filename}}:\n\n'
              .. '```{{filetype}}\n{{selection}}\n```\n\n'
              .. 'Please respond by writing table driven unit tests for the code above.'
            local agent = gp.get_command_agent()
            gp.Prompt(params, gp.Target.enew, nil, agent.model, template, agent.system_prompt)
          end,
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
      vim.keymap.set({ 'n', 'i' }, '<C-g>c', '<cmd>GpChatNew vsplit<cr>', keymapOptions '[C]hat')
      vim.keymap.set('v', '<C-g>c', ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions '[C]hat')
      vim.keymap.set({ 'n', 'i' }, '<C-g>t', '<cmd>GpChatToggle<cr>', keymapOptions '[T]oggle')
      vim.keymap.set({ 'n', 'i' }, '<C-g>h', '<cmd>GpChatFinder<cr>', keymapOptions 'Chat [H]istory')

      -- Prompt commands
      vim.keymap.set({ 'n', 'i' }, '<C-g>a', '<cmd>GpAppend<cr>', keymapOptions '[A]ppend')
      vim.keymap.set({ 'n', 'i' }, '<C-g>p', '<cmd>GpPrepend<cr>', keymapOptions '[P]repend')
      vim.keymap.set('v', '<C-g>r', ":<C-u>'<,'>GpRewrite<cr>", keymapOptions '[R]ewrite')
      vim.keymap.set('v', '<C-g>a', ":<C-u>'<,'>GpAppend<cr>", keymapOptions '[A]ppend')
      vim.keymap.set('v', '<C-g>p', ":<C-u>'<,'>GpPrepend<cr>", keymapOptions '[P]repend')
      vim.keymap.set('v', '<C-g>i', ":<C-u>'<,'>GpImplement<cr>", keymapOptions '[I]mplement')

      -- Selection commands
      vim.keymap.set('v', '<C-g>e', ":<C-u>'<,'>GpCodeExplain<cr>", keymapOptions '[E]xplain')
      vim.keymap.set('v', '<C-g>s', ":<C-u>'<,'>GpCodeReview<cr>", keymapOptions '[S]crutinize')
      vim.keymap.set('v', '<C-g>u', ":<C-u>'<,'>GpUnitTests<cr>", keymapOptions '[U]nit Tests')

      -- Global Commands
      vim.keymap.set({ 'n', 'i' }, '<C-g>x', '<cmd>GpContext<cr>', keymapOptions 'Conte[X]t')
      vim.keymap.set('v', '<C-g>x', ":<C-u>'<,'>GpContext<cr>", keymapOptions 'Conte[X]t')
      vim.keymap.set({ 'n', 'i', 'v', 'x' }, '<C-g>s', '<cmd>GpStop<cr>', keymapOptions '[S]top')
      vim.keymap.set({ 'n', 'i', 'v', 'x' }, '<C-g>n', '<cmd>GpNextAgent<cr>', keymapOptions '[N]ext Agent')
    end,
  },
}
