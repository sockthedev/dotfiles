return {
  {
    'robitx/gp.nvim',
    config = function()
      local chat_system_prompt = 'You are an AI assistant to an experienced full stack web developer.\n\n'
        .. 'Please obey the following rules:\n\n'
        .. '- Keep your answers answers concise. Only provide brief explanations unless explicitly asked to provide more detailed explanations.\n'
        .. '- When modifying existing code focus on the minimal changes required.\n'
        .. '- Only answer if you are absolutely sure.\n'
        .. '- Ask questions if you need clarification.\n'
        .. '- Always respond in markdown format.\n'
        .. '- Always wrap code you create in a markdown code block.\n'

      local code_system_prompt = 'You are an AI working as a code editor.\n\n'
        .. 'YOU MUST ONLY RESPOND WITH THE CODE. DO NOT PROVIDE ANY EXPLAINATION OR COMMENTARY.\n\n'
        .. 'START AND END YOUR ANSWER WITH A CODE BLOCKS DEFINITION (i.e. "```")'

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
          googleai = {
            disable = false,
            secret = { 'cat', os.getenv 'HOME' .. '/.googleai_api_key' },
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
            provider = 'googleai',
            name = 'ChatGemini',
            chat = true,
            command = false,
            model = { model = 'gemini-2.0-pro-exp-02-05', temperature = 0, top_p = 1, max_tokens = 8192 },
            -- model = { model = 'gemini-2.0-flash-thinking-exp-01-21', temperature = 0, top_p = 1, max_tokens = 8192 },
            -- model = { model = 'gemini-2.0-flash-001', temperature = 0, top_p = 1, max_tokens = 8192 },
            system_prompt = chat_system_prompt,
          },
          {
            provider = 'googleai',
            name = 'CodeGemini',
            chat = false,
            command = true,
            model = { model = 'gemini-2.0-pro-exp-02-05', temperature = 0, top_p = 1, max_tokens = 8192 },
            -- model = { model = 'gemini-2.0-flash-thinking-exp-01-21', temperature = 0, top_p = 1, max_tokens = 8192 },
            -- model = { model = 'gemini-2.0-flash-001', temperature = 0, top_p = 1, max_tokens = 8192 },
            system_prompt = code_system_prompt,
          },
          {
            provider = 'anthropic',
            name = 'ChatClaude',
            chat = true,
            command = false,
            model = {
              -- in: $3 / million
              -- out: $15 / million
              -- context: 200k
              -- ouput: 8192, or 64000 with thinking, or 128k with the beta header
              -- Include the beta header output-128k-2025-02-19 in your API request to increase the maximum output token length to 128k tokens for Claude 3.7 Sonnet.
              model = 'claude-3-7-sonnet-20250219',
              temperature = 0,
              top_p = 1,
              max_tokens = 64000,
            },
            system_prompt = chat_system_prompt,
          },
          {
            provider = 'anthropic',
            name = 'CodeClaude',
            chat = false,
            command = true,
            model = {
              model = 'claude-3-7-sonnet-20250219',
              temperature = 0,
              top_p = 1,
              max_tokens = 64000,
            },
            system_prompt = code_system_prompt,
          },
          {
            provider = 'openai',
            name = 'ChatOpenAi',
            chat = true,
            command = false,
            model = {
              model = 'o3-mini-2025-01-31',
              reasoning_effort = 'high',
            },
            system_prompt = chat_system_prompt,
          },
          {
            provider = 'openai',
            name = 'CodeOpenAi',
            chat = false,
            command = true,
            model = {
              model = 'o3-mini-2025-01-31',
              reasoning_effort = 'high',
            },
            system_prompt = code_system_prompt,
          },
          {
            provider = 'ollama',
            name = 'ChatLocal',
            chat = true,
            command = false,
            model = { temperature = 0, top_p = 1 },
            system_prompt = chat_system_prompt,
          },
          {
            provider = 'ollama',
            name = 'CodeLocal',
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
              .. 'Respond with the following:\n\n'
              .. '  - a code block containing the rewritten code\n\n'
              .. '  - a brief explanation of the changes that were made along with the reasons for doing so\n\n'
              .. '  - a "diff" code block that shows the code changes in a diff format.\n\n'
            local agent = gp.get_chat_agent()
            local input_prompt = '🤖 ' .. agent.name .. ' ~'
            gp.Prompt(params, gp.Target.popup, agent, template, input_prompt)
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

      -- Monkey patch the dispatcher after setup
      local dispatcher = require 'gp.dispatcher'
      local original_prepare_payload = dispatcher.prepare_payload
      dispatcher.prepare_payload = function(messages, model, provider)
        local output = original_prepare_payload(messages, model, provider)

        if provider == 'anthropic' then
          output.temperature = 1 -- required for thinking mode
          output.top_p = nil -- required for thinking mode
          output.thinking = {
            type = 'enabled',
            budget_tokens = 32000,
          }
        elseif provider == 'openai' and model.model:sub(1, 2) == 'o3' then
          for i = #messages, 1, -1 do
            if messages[i].role == 'system' then
              table.remove(messages, i)
            end
          end
          output.max_tokens = nil
          output.temperature = nil
          output.top_p = nil
          output.stream = true
        end

        return output
      end

      local function keymapOptions(desc)
        return {
          noremap = true,
          silent = true,
          nowait = true,
          desc = desc,
        }
      end

      -- Chat commands

      vim.keymap.set({ 'n', 'i' }, '<C-g>n', '<cmd>GpChatNew<cr>', keymapOptions '[n]ew chat')
      vim.keymap.set('v', '<C-g>n', ":<C-u>'<,'>GpChatNew<cr>", keymapOptions '[n]ew chat')
      vim.keymap.set({ 'n', 'i' }, '<C-g>\\', '<cmd>GpChatNew vsplit<cr>', keymapOptions 'new chat [v]ertical split')
      vim.keymap.set('v', '<C-g>\\', ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions '[n]ew chat')
      vim.keymap.set({ 'n', 'i' }, "<C-g>'", '<cmd>GpChatNew split<cr>', keymapOptions 'new chat vertical split')
      vim.keymap.set('v', "<C-g>'", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions 'new chat horizontal split')
      vim.keymap.set({ 'n', 'i' }, '<C-g>h', '<cmd>GpChatFinder<cr>', keymapOptions '[h]istory')

      -- Prompt commands

      vim.keymap.set({ 'n', 'i' }, '<C-g>a', '<cmd>GpAppend<cr>', keymapOptions '[a]ppend')
      vim.keymap.set('v', '<C-g>a', ":<C-u>'<,'>GpAppend<cr>", keymapOptions '[a]ppend')
      vim.keymap.set({ 'n', 'i' }, '<C-g>p', '<cmd>GpPrepend<cr>', keymapOptions '[p]repend')
      vim.keymap.set('v', '<C-g>p', ":<C-u>'<,'>GpPrepend<cr>", keymapOptions '[p]repend')

      -- Selection commands

      vim.keymap.set('v', '<C-g>i', ":<C-u>'<,'>GpImplement<cr>", keymapOptions '[i]mplement')
      vim.keymap.set('v', '<C-g>q', ":<C-u>'<,'>GpRewrite<cr>", keymapOptions '[q]uick edit')
      vim.keymap.set('v', '<C-g>e', ":<C-u>'<,'>GpRewriteToDiff<cr>", keymapOptions '[e]dit')
      vim.keymap.set('v', '<C-g>d', ":<C-u>'<,'>GpCodeExplain<cr>", keymapOptions '[d]escribe')
      vim.keymap.set('v', '<C-g>r', ":<C-u>'<,'>GpCodeReview<cr>", keymapOptions '[r]eview')
      vim.keymap.set('v', '<C-g>t', ":<C-u>'<,'>GpUnitTests<cr>", keymapOptions 'create [t]ests')

      -- Global commands

      vim.keymap.set({ 'n', 'i', 'v' }, '<C-g>x', function()
        if vim.fn.mode() == 'v' then
          return ":<C-u>'<,'>GpContext<cr>"
        end
        return '<cmd>GpContext<cr>'
      end, keymapOptions 'Conte[x]t')

      vim.keymap.set({ 'n', 'i', 'v' }, '<C-g>s', '<cmd>GpStop<cr>', keymapOptions '[s]top')
    end,
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
          auto_trigger = true,
          keymap = {
            accept = '<M-CR>',
            accept_word = '<M-]>',
            accept_line = '<M-]>',
            prev = '<M-Right>',
            next = '<M-Left>',
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
}
