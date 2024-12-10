-- Note to self. NEVER try to add Java support again. DON'T do it. It's a rabbit hole that will consume you.

return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {

      -- Automatically install LSPs and related tools to stdpath for neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'nvim-java/nvim-java',

      -- Displays LSP loading status
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',

      -- JSON schemas
      'b0o/schemastore.nvim',

      -- Show LSP Signature during edits
      -- Handy for seeing what the current argument to a function requires
      -- Toggle it via the `toggle_key` (<C-M-k>).
      -- I've disabled it from auto showing as it is so noisy when it does.
      {
        'ray-x/lsp_signature.nvim',
        event = 'VeryLazy',
        opts = {
          floating_window = false,
          hint_enable = false,
          toggle_key = '<C-M-k>',
        },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),

        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-T>.
          map('gd', require('telescope.builtin').lsp_definitions, 'Go to [d]efinition')
          -- map('gd', vim.lsp.buf.definition, 'Go to [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header
          map('gD', vim.lsp.buf.declaration, 'Go to [D]eclaration')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, 'Go to [r]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, 'Go to [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>te', require('telescope.builtin').lsp_type_definitions, 'type d[e]finition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ts', require('telescope.builtin').lsp_document_symbols, 'document [s]ymbols')

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>ty', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'workspace s[y]mbols')

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map('<leader>cn', vim.lsp.buf.rename, 'Re[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[a]ction', { 'n', 'x' })

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          map('K', vim.lsp.buf.hover, 'Do[k]umentation')

          -- The following is our configuration to enable highlighting words under cursor based on the LSP
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            -- vim.api.nvim_create_autocmd('LspDetach', {
            --   group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            --   callback = function(event4)
            --     vim.lsp.buf.clear_references()
            --     vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event4.buf }
            --   end,
            -- })

            local function highlight_word()
              vim.lsp.buf.clear_references()
              vim.lsp.buf.document_highlight()
            end

            vim.keymap.set(
              'n',
              '<leader>ch',
              highlight_word,
              { noremap = true, silent = true, buffer = event.buf, desc = '[h]ighlight' }
            )
            vim.keymap.set(
              'n',
              '<leader>cx',
              vim.lsp.buf.clear_references,
              { noremap = true, silent = true, buffer = event.buf, desc = 'Clear Highlight [x]' }
            )
          end

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.keymap.set('n', '<leader>ci', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, { buffer = event.buf, desc = 'Toggle [I]nlays' })
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
      -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
      local servers = {
        bashls = {
          filetypes = { 'sh', 'zsh' },
          settings = {
            bash = {
              filetypes = { 'sh', 'zsh' },
            },
          },
        },
        cssls = {},
        docker_compose_language_service = {},
        dockerls = {},
        eslint = {
          root_dir = require('lspconfig').util.root_pattern('.eslintrc.json', '.eslintrc'),
        },
        html = {},
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = false },
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = false,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = false,
              },
            },
          },
        },
        kotlin_language_server = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- disable noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        pyright = {
          root_dir = require('lspconfig').util.root_pattern(
            'pyproject.toml',
            'requirements.txt',
            'Pipfile',
            'pyrightconfig.json'
          ),
          filetype = { 'python' },
        },
        ruff = {
          capabilities = {
            -- Disable hover in favor of Pyright
            hoverProvider = false,
          },
        },
        tailwindcss = {},
        -- typescript lsp based off of the vscode one
        vtsls = {
          root_dir = require('lspconfig').util.root_pattern(
            'pnpm-workspace.yaml',
            'pnpm-lock.yaml',
            'package-lock.json',
            'yarn.lock',
            'bun.lockb',
            '.git'
          ),
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
            },
            javascript = {
              inlayHints = {
                parameterNames = {
                  enabled = 'all',
                  suppressWhenArgumentMatchesName = false,
                },
                parameterTypes = {
                  enabled = true,
                },
              },
            },
            typescript = {
              tsserver = {
                maxTsServerMemory = 6144,
              },
              inlayHints = {
                parameterNames = {
                  enabled = 'all',
                  suppressWhenArgumentMatchesName = false,
                },
                parameterTypes = {
                  enabled = true,
                },
              },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = '',
              },
              schemas = require('schemastore').yaml.schemas(),
              validate = false,
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
      local ensure_installed = vim.tbl_map(function(key)
        return key == 'tsserver' and 'ts_ls' or key
      end, vim.tbl_keys(servers or {}))
      vim.list_extend(ensure_installed, {
        'goimports', -- Format imports in Go (gopls includes gofmt already)
        'prettierd', -- Used to format JavaScript, TypeScript, HTML, JSON, etc.
        'stylua', -- Used to format Lua code
        'ktlint', -- Used to format (and lint) Kotlin code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            server_name = server_name == 'tsserver' and 'ts_ls' or server_name
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

            -- FIXME: workaround for https://github.com/neovim/neovim/issues/28058
            for _, v in pairs(server) do
              if type(v) == 'table' and v.workspace then
                v.workspace.didChangeWatchedFiles = {
                  dynamicRegistration = false,
                  relativePatternSupport = false,
                }
              end
            end

            require('lspconfig')[server_name].setup(server)
          end,
          jdtls = function()
            require('java').setup {
              -- Your custom jdtls settings goes here
            }

            require('lspconfig').jdtls.setup {
              -- Your custom nvim-java configuration goes here
            }
          end,
        },
      }

      -- disable the diagnostics for .env files
      local group = vim.api.nvim_create_augroup('__env', { clear = true })
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = { '.env', '.env.*' },
        group = group,
        callback = function(args)
          ---@diagnostic disable-next-line: deprecated
          vim.diagnostic.disable(args.buf)
        end,
      })

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
    opts = {
      run_as_monorepo = true,
    },
  },

  -- Translates obscure TypeScript errors into human-readable messages
  {
    'dmmulroy/ts-error-translator.nvim',
    opts = {},
  },

  -- A panel to view the logs from your LSP servers.
  {
    'mhanberg/output-panel.nvim',
    event = 'VeryLazy',
    config = function()
      require('output_panel').setup()
    end,
  },
}
