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
      -- Displays LSP loading status
      { 'j-hui/fidget.nvim', opts = {} },

      -- We use this to install language servers and tools
      {
        'mason-org/mason-lspconfig.nvim',
        opts = {},
        dependencies = {
          {
            'mason-org/mason.nvim',
            opts = {
              ui = {
                border = 'single',
              },
            },
          },
          'neovim/nvim-lspconfig',
        },
      },
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- JSON schemas
      'b0o/schemastore.nvim',

      -- blink provides additional LSP capabilities
      'saghen/blink.cmp',
    },
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          --- language servers
          'cssls',
          'gopls',
          'html',
          'jsonls',
          'lua_ls',
          -- 'pyright',
          -- 'ruff',
          'tailwindcss',
          'vtsls',
          'yamlls',
          -- tools
          'goimports', -- Format imports in Go (gopls includes gofmt already)
          'prettierd', -- Used to format JavaScript, TypeScript, HTML, JSON, etc.
          'stylua', -- Used to format Lua code
        },
      }

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

      vim.lsp.config('*', {
        capabilities = vim.tbl_deep_extend(
          'force',
          {},
          vim.lsp.protocol.make_client_capabilities(),
          require('blink.cmp').get_lsp_capabilities()
        ),
        textDocument = {
          -- Required for nvim-ufo code folding (see folding.lua)
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      })

      vim.lsp.enable 'cssls'
      vim.lsp.enable 'gopls'
      vim.lsp.enable 'html'
      vim.lsp.enable 'json_ls'
      vim.lsp.enable 'lua_ls'
      vim.lsp.enable 'tailwindcss'
      -- vim.lsp.enable 'tsgo'
      vim.lsp.enable 'vtsls'
      vim.lsp.enable 'yamlls'

      vim.diagnostic.config {
        update_in_insert = true,
        severity_sort = true,
        float = {
          border = 'single',
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
