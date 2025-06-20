return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  { 'Bilal2453/luvit-meta', lazy = true },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {

      -- Automatically install LSPs and related tools to stdpath for neovim
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      {
        'williamboman/mason.nvim',
        opts = {
          ui = {
            border = 'single',
          },
        },
      }, -- NOTE: Must be loaded before dependants

      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Displays LSP loading status
      { 'j-hui/fidget.nvim', opts = {} },

      -- JSON schemas
      'b0o/schemastore.nvim',

      -- blink provides additional LSP capabilities
      'saghen/blink.cmp',
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
          map('gd', vim.lsp.buf.definition, 'Go to [D]efinition')
          -- map('gd', require('telescope.builtin').lsp_definitions, 'Go to [d]efinition')

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

          local client = vim.lsp.get_client_by_id(event.data.client_id)

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

      local configs = require 'lspconfig.configs'

      -- Experimental tsgo lsp support (not there yet though)
      if not configs.tsgo then
        configs.tsgo = {
          default_config = {
            -- init_options = { hostInfo = 'neovim' }, -- not implemented yet
            cmd = { 'tsgo', '--lsp', '--stdio' },
            filetypes = {
              'javascript',
              'javascriptreact',
              'javascript.jsx',
              'typescript',
              'typescriptreact',
              'typescript.tsx',
            },
            root_dir = require('lspconfig').util.root_pattern(
              'tsconfig.json',
              'pnpm-lock.yaml',
              'package-lock.json',
              'yarn.lock',
              'bun.lockb',
              '.git'
            ),
            -- single_file_support = true,
            -- Add any specific settings the tsgo LSP might need
          },
        }
      end

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
          root_dir = require('lspconfig').util.root_pattern(
            '.eslintrc.json',
            '.eslintrc',
            '.eslintrc.js',
            '.eslintrc.cjs',
            'eslint.config.js',
            'eslint.config.cjs',
            'eslint.config.mjs',
            'eslint.config.ts',
            'eslint.config.mts',
            'eslint.config.cts'
          ),
          autostart = true,
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

        -- kotlin = {},

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

        -- typescript-go lsp
        -- tsgo = {},

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
              preferences = {
                includePackageJsonAutoImports = 'off',
              },
            },
            typescript = {
              tsserver = {
                maxTsServerMemory = 4096,
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

      -- You can add other tools here that you want Mason to install for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_map(
        function(key)
          if key == 'tsserver' then
            return 'ts_ls'
          elseif key == 'tsgo' then
            return nil -- Skip tsgo as it's manually installed
          elseif key == 'kotlin' then
            return nil -- Skip kotlin as it's manually installed
          else
            return key
          end
        end,
        vim.tbl_filter(function(key)
          -- return key ~= 'kotlin'
          return key ~= 'tsgo'
        end, vim.tbl_keys(servers or {}))
      )

      vim.list_extend(ensure_installed, {
        'goimports', -- Format imports in Go (gopls includes gofmt already)
        'prettierd', -- Used to format JavaScript, TypeScript, HTML, JSON, etc.
        'stylua', -- Used to format Lua code
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      local capabilities = {
        textDocument = {
          -- Required for nvim-ufo code folding (see folding.lua)
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            server_name = server_name == 'tsserver' and 'ts_ls' or server_name
            local server = servers[server_name] or {}
            -- LSP servers and clients are able to communicate to each other what features they support.
            --  By default, Neovim doesn't support everything that is in the LSP Specification.
            --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
            --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
            capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

            -- -- FIXME: workaround for https://github.com/neovim/neovim/issues/28058
            -- for _, v in pairs(server) do
            --   if type(v) == 'table' and v.workspace then
            --     v.workspace.didChangeWatchedFiles = {
            --       dynamicRegistration = false,
            --       relativePatternSupport = false,
            --     }
            --   end
            -- end

            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      -- Manually set up tsgo since it's not managed by Mason
      if servers.tsgo then
        local tsgo_config = servers.tsgo
        capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
        tsgo_config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, tsgo_config.capabilities or {})
        require('lspconfig').tsgo.setup(tsgo_config)
      end

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

  -- Nice symbol selector
  {
    'bassamsdata/namu.nvim',
    config = function()
      require('namu').setup {
        -- Enable the modules you want
        namu_symbols = {
          enable = true,
          options = {
            AllowKinds = {
              default = {
                'Function',
                'Method',
                'Class',
                'Module',
                'Property',
                'Variable',
                -- "Constant",
                -- "Enum",
                -- "Interface",
                -- "Field",
                -- "Struct",
              },
            },
            display = {
              format = 'tree_guides',
            },
          }, -- here you can configure namu
        },
        -- Optional: Enable other modules if needed
        ui_select = { enable = false }, -- vim.ui.select() wrapper
        preview = {
          highlight_on_move = false,
          highlight_mode = 'select',
        },
        colorscheme = {
          enable = false,
          options = {
            persist = true,
            write_shada = true,
          },
        },
        highlight = 'NamuPreview',
      }

      vim.keymap.set('n', '<leader>,', ':Namu symbols<cr>', {
        desc = 'Jump to symbol',
        silent = true,
      })
    end,
  },

  -- TypeScript type checking
  {
    'dmmulroy/tsc.nvim',
    opts = {
      run_as_monorepo = true,
      use_trouble_qflist = true,
    },
  },
}
