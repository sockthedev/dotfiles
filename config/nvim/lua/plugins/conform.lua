return {
  { -- Autoformat
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup {
        notify_on_error = false,
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
        formatters_by_ft = {
          css = { 'prettierd' },
          -- go = { 'gofmt' },
          go = { 'goimports' }, -- goimports does the same as gofmt and manages imports
          graphql = { 'prettierd' },
          html = { 'prettierd' },
          javascript = { 'prettierd' },
          javascriptreact = { 'prettierd' },
          json = { 'prettierd' },
          lua = { 'stylua' },
          markdown = { 'prettierd' },
          python = { 'ruff_format' },
          typescript = { 'prettierd' },
          typescriptreact = { 'prettierd' },
          yaml = { 'prettierd' },
        },
      }

      -- Adds a command to toggle autoformat on save
      vim.api.nvim_create_user_command('FormatToggle', function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        print('Autoformat on save is now ' .. (vim.g.disable_autoformat and 'disabled' or 'enabled'))
      end, {})

      -- Adds a Format command to perform format on the entire buffer
      vim.api.nvim_create_user_command('Format', function()
        require('conform').format { async = true, lsp_fallback = true }
      end, {})

      -- Adds a :FormatRange command to perform format on a selected range
      vim.api.nvim_create_user_command('FormatRange', function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ['end'] = { args.line2, end_line:len() },
          }
        end
        require('conform').format { async = true, lsp_fallback = true, range = range }
      end, { range = true })
    end,
  },
}
