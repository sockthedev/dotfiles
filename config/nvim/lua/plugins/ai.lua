return {
  {
    'robitx/gp.nvim',
    config = function()
      local chat_system_prompt = 'You are an AI assistant to an experienced full stack web developer.\n\n'
        .. 'The user provided the additional info about how they would like you to respond:\n\n'
        .. '- Keep your answers concise, unless explicitly asked to do so.\n'
        .. '- Do not provide explanations, unless explicitly asked to do so.\n'
        .. '- When helping to modify or understand existing code only show the minimal changes needed\n'
        .. '- Do not make guesses - rather say you are unsure.\n'
        .. '- Ask questions if you need clarification.\n'
        .. '- DO NOT HALLUCINATE.\n'
        .. '- Think about your answers.\n'

      local code_system_prompt = 'You are an AI working as a code editor.\n\n'
        .. 'Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n'
        .. 'START AND END YOUR ANSWER WITH:\n\n```'

      require('gp').setup {
        chat_free_cursor = true, -- don't make cursor follow the response stream
        chat_template = require('gp.defaults').short_chat_template,
        providers = {
          openai = {
            disable = false,
            secret = { 'cat', os.getenv 'HOME' .. '/.openai_api_key' },
          },
          anthropic = {
            disable = false,
            secret = { 'cat', os.getenv 'HOME' .. '/.anthropic_api_key' },
          },
          -- Run via LMStudio
          ollama = {
            endpoint = 'http://localhost:1234/v1/chat/completions',
          },
        },
        -- default command agents (model + persona)
        -- name, model and system_prompt are mandatory fields
        -- to use agent for chat set chat = true, for command set command = true
        -- to remove some default agent completely set it just with the name like:
        -- agents = {  { name = "ChatGPT4" }, ... },
        agents = {
          {
            provider = 'anthropic',
            name = 'ChatAnthropic',
            chat = true,
            command = false,
            model = { model = 'claude-3-5-sonnet-20241022', temperature = 0, top_p = 1 },
            system_prompt = chat_system_prompt,
          },
          {
            provider = 'anthropic',
            name = 'CodeAnthropic',
            chat = false,
            command = true,
            model = { model = 'claude-3-5-sonnet-20241022', temperature = 0, top_p = 1 },
            system_prompt = code_system_prompt,
          },
          {
            provider = 'openai',
            name = 'ChatOpenAI',
            chat = true,
            command = false,
            model = { model = 'chatgpt-4o-latest', temperature = 0, top_p = 1 },
            system_prompt = chat_system_prompt,
          },
          {
            provider = 'openai',
            name = 'CodeOpenAI',
            chat = false,
            command = true,
            model = { model = 'chatgpt-4o-latest', temperature = 0, top_p = 1 },
            system_prompt = code_system_prompt,
          },
          {
            provider = 'ollama',
            name = 'ChatLmStudio',
            chat = true,
            command = false,
            model = { temperature = 0, top_p = 1 },
            system_prompt = chat_system_prompt,
          },
          {
            provider = 'ollama',
            name = 'CodeLmStudio',
            chat = false,
            command = true,
            model = { temperature = 0, top_p = 1 },
            system_prompt = code_system_prompt,
          },
        },
        hooks = {
          CodeExplain = function(gp, params)
            local template = 'I have the following code from {{filename}}:\n\n'
              .. '```{{filetype}}\n{{selection}}\n```\n\n'
              .. 'Please respond by explaining the code above. Focus on the behaviour of the code. What is it doing? What is its purpose?'
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.vnew 'markdown', agent, template, nil, nil, function()
              vim.cmd 'normal! 1G0'
              vim.cmd [[execute "normal! \<Esc>"]]
            end)
          end,
          CodeReview = function(gp, params)
            local template = 'I have the following code from {{filename}}:\n\n'
              .. '```{{filetype}}\n{{selection}}\n```\n\n'
              .. 'Please perform a code review on this as if you were a senior engineer. Feel free to include code blocks of suggested improvements in your response. You want to help the engineer become a better engineer.'
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.vnew 'markdown', agent, template, nil, nil, function()
              vim.cmd 'normal! 1G0'
              vim.cmd [[execute "normal! \<Esc>"]]
            end)
          end,
          RewriteToDiff = function(gp, params)
            local template = 'I have the following from {{filename}}:\n\n'
              .. '```{{filetype}}\n{{selection}}\n```\n\n'
              .. 'Rewrite it based on these instructions: {{command}}\n\n'
              .. 'Respond with a code block containing the rewritten code, and a brief explanation of the changes that were made along with the reasons for doing so.\n\n'
            local agent = gp.get_chat_agent()
            local input_prompt = '🤖 ' .. agent.name .. ' ~'
            gp.Prompt(params, gp.Target.vnew 'markdown', agent, template, input_prompt, nil, function()
              vim.cmd 'normal! 1G0'
              vim.cmd [[execute "normal! \<Esc>"]]
            end)
          end,
          UnitTests = function(gp, params)
            local template = 'I have the following code from {{filename}}:\n\n'
              .. '```{{filetype}}\n{{selection}}\n```\n\n'
              .. 'Please respond by writing unit tests for the code above.'
            local agent = gp.get_command_agent()
            gp.Prompt(params, gp.Target.vnew, agent, template)
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

      vim.keymap.set({ 'n', 'i' }, '<C-a>n', '<cmd>GpChatNew<cr>', keymapOptions '[n]ew chat')
      vim.keymap.set('v', '<C-a>n', ":<C-u>'<,'>GpChatNew<cr>", keymapOptions '[n]ew chat')
      vim.keymap.set({ 'n', 'i' }, '<C-a>h', '<cmd>GpChatFinder<cr>', keymapOptions '[h]istory')

      -- Prompt commands

      vim.keymap.set({ 'n', 'i' }, '<C-a>a', '<cmd>GpAppend<cr>', keymapOptions '[a]ppend')
      vim.keymap.set('v', '<C-a>a', ":<C-u>'<,'>GpAppend<cr>", keymapOptions '[a]ppend')
      vim.keymap.set({ 'n', 'i' }, '<C-a>p', '<cmd>GpPrepend<cr>', keymapOptions '[p]repend')
      vim.keymap.set('v', '<C-a>p', ":<C-u>'<,'>GpPrepend<cr>", keymapOptions '[p]repend')

      -- Selection commands

      vim.keymap.set('v', '<C-a>i', ":<C-u>'<,'>GpImplement<cr>", keymapOptions '[i]mplement')
      vim.keymap.set('v', '<C-a>e', ":<C-u>'<,'>GpRewriteToDiff<cr>", keymapOptions '[e]dit')
      vim.keymap.set('v', '<C-a>d', ":<C-u>'<,'>GpCodeExplain<cr>", keymapOptions '[d]escribe')
      vim.keymap.set('v', '<C-a>r', ":<C-u>'<,'>GpCodeReview<cr>", keymapOptions '[r]eview')
      vim.keymap.set('v', '<C-a>t', ":<C-u>'<,'>GpUnitTests<cr>", keymapOptions 'create [t]ests')

      -- Global commands

      vim.keymap.set({ 'n', 'i', 'v' }, '<C-a>x', function()
        if vim.fn.mode() == 'v' then
          return ":<C-u>'<,'>GpContext<cr>"
        end
        return '<cmd>GpContext<cr>'
      end, keymapOptions 'Conte[x]t')

      vim.keymap.set({ 'n', 'i', 'v' }, '<C-a>s', '<cmd>GpStop<cr>', keymapOptions '[s]top')
    end,
  },

  {
    'supermaven-inc/supermaven-nvim',

    config = function()
      require('supermaven-nvim').setup {
        keymaps = {
          accept_suggestion = '<M-CR>',
          clear_suggestion = '<M-[>',
          accept_word = '<M-]>',
        },
      }
    end,
  },

  -- {
  --   'yetone/avante.nvim',
  --   event = 'VeryLazy',
  --   lazy = false,
  --   version = false, -- set this if you want to always pull the latest change
  --   opts = {
  --     -- add any opts here
  --   },
  --   build = 'make',
  --   dependencies = {
  --     'stevearc/dressing.nvim',
  --     'nvim-lua/plenary.nvim',
  --     'MunifTanjim/nui.nvim',
  --     'hrsh7th/nvim-cmp',
  --     'nvim-tree/nvim-web-devicons',
  --     -- support for image pasting
  --     {
  --       'HakonHarnes/img-clip.nvim',
  --       event = 'VeryLazy',
  --       opts = {
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --         },
  --       },
  --     },
  --     -- Make sure to set this up properly if you have lazy=true
  --     {
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { 'markdown', 'Avante' },
  --       },
  --       ft = { 'markdown', 'Avante' },
  --     },
  --   },
  -- },

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
  --         auto_trigger = true,
  --         keymap = {
  --           accept = '<M-CR>',
  --           accept_word = '<M-Right>',
  --           accept_line = '<M-Down>',
  --           prev = '<M-[>',
  --           next = '<M-]>',
  --           dismiss = '<C-]>',
  --         },
  --       },
  --       panel = {
  --         auto_refresh = false,
  --         keymap = {
  --           accept = '<CR>',
  --           jump_prev = '<M-[>',
  --           jump_next = '<M-]>',
  --           refresh = 'gr',
  --           open = '<M-CR>',
  --         },
  --       },
  --     }
  --   end,
  -- },

  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   branch = 'main',
  --   dependencies = {
  --     { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
  --     { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  --   },
  --   build = 'make tiktoken',
  --   config = function()
  --     require('CopilotChat').setup {
  --       -- See Configuration section for rest
  --     }
  --
  --     local function keymapOptions(desc)
  --       return {
  --         noremap = true,
  --         silent = true,
  --         nowait = true,
  --         desc = desc,
  --       }
  --     end
  --
  --     -- Chat commands
  --     vim.keymap.set({ 'n', 'i' }, '<C-c>c', '<cmd>CopilotChatOpen<cr>', keymapOptions '[C]hat')
  --     vim.keymap.set({ 'n', 'i' }, '<C-c>t', '<cmd>CopilotChatToggle<cr>', keymapOptions '[T]oggle Chat')
  --     vim.keymap.set({ 'n', 'i' }, '<C-c>r', '<cmd>CopilotChatReset<cr>', keymapOptions '[R]reset')
  --     vim.keymap.set({ 'n', 'i' }, '<C-c>x', '<cmd>CopilotChatClose<cr>', keymapOptions 'Close [X]')
  --
  --     -- Selection commands
  --     vim.keymap.set('v', '<C-c>c', ":<C-u>'<,'>CopilotChatCommit<cr>", keymapOptions '[C]ommit Message')
  --     vim.keymap.set('v', '<C-c>s', ":<C-u>'<,'>CopilotChatCommitStaged<cr>", keymapOptions 'Commit Message [S]taged')
  --     vim.keymap.set('v', '<C-c>e', ":<C-u>'<,'>CopilotChatExplain<cr>", keymapOptions '[E]xplain')
  --     vim.keymap.set('v', '<C-c>f', ":<C-u>'<,'>CopilotChatFix<cr>", keymapOptions '[F]ix')
  --     vim.keymap.set('v', '<C-c>x', ":<C-u>'<,'>CopilotChatFix<cr>", keymapOptions 'Fi[X] Diagnostic')
  --     vim.keymap.set('v', '<C-c>d', ":<C-u>'<,'>CopilotChatDocs<cr>", keymapOptions '[D]ocs')
  --     vim.keymap.set('v', '<C-c>r', ":<C-u>'<,'>CopilotChatReview<cr>", keymapOptions '[R]eview')
  --     vim.keymap.set('v', '<C-c>o', ":<C-u>'<,'>CopilotChatOptimize<cr>", keymapOptions '[O]ptimize')
  --     vim.keymap.set('v', '<C-c>t', ":<C-u>'<,'>CopilotChatTests<cr>", keymapOptions '[T]ests')
  --   end,
  -- },
}
