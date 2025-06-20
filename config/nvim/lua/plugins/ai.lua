return {
  {
    'frankroeder/parrot.nvim',
    dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
    config = function()
      require('parrot').setup {
        providers = {
          anthropic = {
            name = 'anthropic',
            endpoint = 'https://api.anthropic.com/v1/messages',
            model_endpoint = 'https://api.anthropic.com/v1/models',
            api_key = os.getenv 'NVIM_ANTHROPIC_API_KEY',
            params = {
              chat = { max_tokens = 4096 },
              command = { max_tokens = 4096 },
            },
            topic = {
              model = 'claude-3-5-haiku-latest',
              params = { max_tokens = 32 },
            },
            headers = function(self)
              return {
                ['Content-Type'] = 'application/json',
                ['x-api-key'] = self.api_key,
                ['anthropic-version'] = '2023-06-01',
              }
            end,
            models = {
              'claude-opus-4-20250514',
              'claude-sonnet-4-20250514',
            },
            preprocess_payload = function(payload)
              for _, message in ipairs(payload.messages) do
                message.content = message.content:gsub('^%s*(.-)%s*$', '%1')
              end
              if payload.messages[1] and payload.messages[1].role == 'system' then
                -- remove the first message that serves as the system prompt as anthropic
                -- expects the system prompt to be part of the API call body and not the messages
                payload.system = payload.messages[1].content
                table.remove(payload.messages, 1)
              end
              return payload
            end,
          },
          gemini = {
            name = 'gemini',
            endpoint = function(self)
              return 'https://generativelanguage.googleapis.com/v1beta/models/'
                .. self._model
                .. ':streamGenerateContent?alt=sse'
            end,
            model_endpoint = function(self)
              return { 'https://generativelanguage.googleapis.com/v1beta/models?key=' .. self.api_key }
            end,
            api_key = os.getenv 'GEMINI_API_KEY',
            params = {
              chat = { temperature = 1.1, topP = 1, topK = 10, maxOutputTokens = 8192 },
              command = { temperature = 0.8, topP = 1, topK = 10, maxOutputTokens = 8192 },
            },
            topic = {
              model = 'gemini-2.5-flash-preview-05-20',
              params = { maxOutputTokens = 64 },
            },
            headers = function(self)
              return {
                ['Content-Type'] = 'application/json',
                ['x-goog-api-key'] = self.api_key,
              }
            end,
            models = {
              'gemini-2.5-pro-preview-05-06',
              'gemini-2.5-flash-preview-05-20',
            },
            preprocess_payload = function(payload)
              local contents = {}
              local system_instruction = nil
              for _, message in ipairs(payload.messages) do
                if message.role == 'system' then
                  system_instruction = { parts = { { text = message.content } } }
                else
                  local role = message.role == 'assistant' and 'model' or 'user'
                  table.insert(
                    contents,
                    { role = role, parts = { { text = message.content:gsub('^%s*(.-)%s*$', '%1') } } }
                  )
                end
              end
              local gemini_payload = {
                contents = contents,
                generationConfig = {
                  temperature = payload.temperature,
                  topP = payload.topP or payload.top_p,
                  maxOutputTokens = payload.max_tokens or payload.maxOutputTokens,
                },
              }
              if system_instruction then
                gemini_payload.systemInstruction = system_instruction
              end
              return gemini_payload
            end,
            process_stdout = function(response)
              if not response or response == '' then
                return nil
              end
              local success, decoded = pcall(vim.json.decode, response)
              if
                success
                and decoded.candidates
                and decoded.candidates[1]
                and decoded.candidates[1].content
                and decoded.candidates[1].content.parts
                and decoded.candidates[1].content.parts[1]
              then
                return decoded.candidates[1].content.parts[1].text
              end
              return nil
            end,
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

      vim.keymap.set({ 'n', 'i' }, '<C-g>n', '<cmd>PrtChatNew<cr>', keymapOptions '[n]ew chat')
      vim.keymap.set('v', '<C-g>n', ":<C-u>'<,'>PrtChatNew<cr>", keymapOptions '[n]ew chat')
      vim.keymap.set({ 'n', 'i' }, '<C-g>\\', '<cmd>PrtChatNew vsplit<cr>', keymapOptions 'new chat [v]ertical split')
      vim.keymap.set('v', '<C-g>\\', ":<C-u>'<,'>PrtChatNew vsplit<cr>", keymapOptions '[n]ew chat')
      vim.keymap.set({ 'n', 'i' }, "<C-g>'", '<cmd>PrtChatNew split<cr>', keymapOptions 'new chat vertical split')
      vim.keymap.set('v', "<C-g>'", ":<C-u>'<,'>PrtChatNew split<cr>", keymapOptions 'new chat horizontal split')
      vim.keymap.set({ 'n', 'i' }, '<C-g>h', '<cmd>PrtChatFinder<cr>', keymapOptions '[h]istory')

      -- Prompt commands

      vim.keymap.set({ 'n', 'i' }, '<C-g>a', '<cmd>PrtAppend<cr>', keymapOptions '[a]ppend')
      vim.keymap.set('v', '<C-g>a', ":<C-u>'<,'>PrtAppend<cr>", keymapOptions '[a]ppend')
      vim.keymap.set({ 'n', 'i' }, '<C-g>p', '<cmd>PrtPrepend<cr>', keymapOptions '[p]repend')
      vim.keymap.set('v', '<C-g>p', ":<C-u>'<,'>PrtPrepend<cr>", keymapOptions '[p]repend')

      -- Selection commands

      vim.keymap.set('v', '<C-g>i', ":<C-u>'<,'>PrtImplement<cr>", keymapOptions '[i]mplement')
      vim.keymap.set('v', '<C-g>q', ":<C-u>'<,'>PrtRewrite<cr>", keymapOptions '[q]uick edit')
      vim.keymap.set('v', '<C-g>e', ":<C-u>'<,'>PrtEdit<cr>", keymapOptions '[e]dit')
      -- vim.keymap.set('v', '<C-g>d', ":<C-u>'<,'>GpCodeExplain<cr>", keymapOptions '[d]escribe')
      -- vim.keymap.set('v', '<C-g>r', ":<C-u>'<,'>GpCodeReview<cr>", keymapOptions '[r]eview')
      -- vim.keymap.set('v', '<C-g>t', ":<C-u>'<,'>GpUnitTests<cr>", keymapOptions 'create [t]ests')
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
