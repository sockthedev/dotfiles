return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- NOTE: required for java
      -- 'nvim-java/nvim-java',
      -- 'nvim-java/lua-async-await',
      -- 'nvim-java/nvim-java-refactor',
      -- 'nvim-java/nvim-java-core',
      -- 'nvim-java/nvim-java-test',
      -- 'nvim-java/nvim-java-dap',
      -- 'MunifTanjim/nui.nvim',
      -- 'mfussenegger/nvim-dap',

      -- Automatically install LSPs and related tools to stdpath for neovim
      {
        'williamboman/mason.nvim',
        -- NOTE: required for java
        -- opts = {
        --   registries = {
        --     'github:nvim-java/mason-registry', -- required for nvim-java
        --     'github:mason-org/mason-registry',
        --   },
        -- },
      },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Displays LSP loading status
      { 'j-hui/fidget.nvim', opts = {} },

      -- JSON schemas
      'b0o/schemastore.nvim',

      -- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
      { 'folke/neodev.nvim', opts = {} },

      -- lsp signature as you type
      -- { 'ray-x/lsp_signature.nvim', opts = {} },
    },
    config = function()
      -- NOTE: required for java
      -- IMPORTANT: make sure to setup java BEFORE lspconfig
      -- require('java').setup {
      --   jdk = {
      --     auto_install = false,
      --   },
      -- }

      -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
      require('neodev').setup {}

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),

        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-T>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          -- map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map('<leader>cn', vim.lsp.buf.rename, '[Code] [R]ename')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event4)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event4.buf }
              end,
            })
          end

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      capabilities = vim.tbl_deep_extend(
        'force',
        capabilities,
        -- Required for nvim-ufo code folding (see folding.lua)
        {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        }
      )

      -- Enable the following language servers
      local servers = {
        cssls = {},
        eslint = {},
        html = {},
        -- NOTE: required for java
        -- jdtls = {
        --   settings = {
        --     java = {
        --       configuration = {
        --         runtimes = {
        --           {
        --             name = 'JavaSE-15',
        --             path = '/Users/sock/.sdkman/candidates/java/19-open/',
        --             default = true,
        --           },
        --         },
        --       },
        --     },
        --   },
        -- },
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        gopls = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${5rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
                -- If lua_ls is really slow on your computer, you can try this instead:
                -- library = { vim.env.VIMRUNTIME },
              },
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        pyright = {
          filetype = { 'python' },
        },
        ruff_lsp = {
          capabilities = {
            -- Disable hover in favor of Pyright
            hoverProvider = false,
          },
        },
        tailwindcss = {},
        tsserver = {
          root_dir = require('lspconfig').util.root_pattern 'pnpm-workspace.yaml',
        },
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = '',
              },
              schemas = require('schemastore').yaml.schemas(),
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      require('mason').setup {
        ui = {
          border = 'single',
        },
      }

      -- You can add other tools here that you want Mason to install for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'prettierd', -- Used to format javascript and typescript
        'stylua', -- Used to format lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      -- UI style configuration
      vim.lsp.handlers['textDocument/hover'] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = 'single', stylize_markdown = false })
      vim.lsp.handlers['textDocument/signatureHelp'] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single', stylize_markdown = false })
      vim.diagnostic.config {
        update_in_insert = true,
        severity_sort = true,
        float = {
          border = 'single',
        },
      }
    end,
  },

  -- TypeScript type checking
  {
    'dmmulroy/tsc.nvim',
    opts = {},
  },

  -- Translates obscure TypeScript errors into human-readable messages
  {
    'dmmulroy/ts-error-translator.nvim',
    opts = {},
  },
}
