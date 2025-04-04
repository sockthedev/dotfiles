return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    keys = {
      { '<C-space>', desc = 'Increment selection', mode = 'x' },
      { '<bs>', desc = 'Schrink selection', mode = 'x' },
    },
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'astro',
          'bash',
          'comment',
          'css',
          'diff',
          'git_config',
          'git_rebase',
          'gitcommit',
          'gitignore',
          'graphql',
          'html',
          'javascript',
          'java',
          'json',
          'jsonc',
          'kotlin',
          'lua',
          'markdown',
          'markdown_inline',
          'python',
          'query',
          'regex',
          'scss',
          'sql',
          'terraform',
          'toml',
          'tsx',
          'typescript',
          'vim',
          'vimdoc',
          'yaml',
        },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = '<nop>',
            node_decremental = '<bs>',
          },
        },
      }

      -- Add some autocmds to map files to the expected syntax
      vim.cmd [[
        autocmd BufRead,BufNewFile *.tf set filetype=terraform
        autocmd BufRead,BufNewFile *.tfvars set filetype=terraform
        autocmd BufRead,BufNewFile *.tfstate set filetype=json
        autocmd BufRead,BufNewFile *.yml set filetype=yaml
        autocmd BufRead,BufNewFile *.graphqls set filetype=graphql
        autocmd BufRead,BufNewFile yarn.lock set filetype=text
      ]]
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-context',

    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesitter-context').setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        multiwindow = false, -- Enable multiwindow support.
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'topline', -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              ['af'] = { query = '@function.outer', desc = 'Select outer part of a function' },
              ['if'] = { query = '@function.inner', desc = 'Select inner part of a function' },
              ['ac'] = { query = '@class.outer', desc = 'Select outer part of a class' },
              ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class' },
              ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>csn'] = { query = '@parameter.inner', desc = 'With [N]ext Parameter' },
            },
            swap_previous = {
              ['<leader>csp'] = { query = '@parameter.inner', desc = 'With [P]revious Parameter' },
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = { query = '@function.outer', desc = 'Next function start' },
              [']]'] = { query = '@class.outer', desc = 'Next class start' },
              [']o'] = { query = '@loop.*', desc = 'Next loop start' },
              [']b'] = { query = '@block.outer', desc = 'Next block start' },
            },
            goto_next_end = {
              [']M'] = { query = '@function.outer', desc = 'Next function end' },
              [']['] = { query = '@class.outer', desc = 'Next class end' },
              [']O'] = { query = '@loop.*', desc = 'Next loop end' },
              [']B'] = { query = '@block.outer', desc = 'Next block end' },
            },
            goto_previous_start = {
              ['[m'] = { query = '@function.outer', desc = 'Previous function start' },
              ['[['] = { query = '@class.outer', desc = 'Previous class start' },
              ['[o'] = { query = '@loop.*', desc = 'Previous loop start' },
              ['[b'] = { query = '@block.outer', desc = 'Previous block start' },
            },
            goto_previous_end = {
              ['[M'] = { query = '@function.outer', desc = 'Previous function end' },
              ['[]'] = { query = '@class.outer', desc = 'Previous class end' },
              ['[O'] = { query = '@loop.*', desc = 'Previous loop end' },
              ['[B'] = { query = '@block.outer', desc = 'Previous block end' },
            },
          },
        },
      }
    end,
  },

  -- quick navigation
  {
    'aaronik/treewalker.nvim',
    config = function()
      require('treewalker').setup {}

      vim.keymap.set({ 'n', 'v' }, '<C-S-Up>', '<cmd>Treewalker Up<cr>', { silent = true })
      vim.keymap.set({ 'n', 'v' }, '<C-S-Down>', '<cmd>Treewalker Down<cr>', { silent = true })
      vim.keymap.set({ 'n', 'v' }, '<C-S-Right>', '<cmd>Treewalker Right<cr>', { silent = true })
      vim.keymap.set({ 'n', 'v' }, '<C-S-Left>', '<cmd>Treewalker Left<cr>', { silent = true })
    end,
  },
}
