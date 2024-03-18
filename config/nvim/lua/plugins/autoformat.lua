return {
  { -- Autoformat
    'stevearc/conform.nvim',
    cmd = { 'Format', 'FormatRange' },
    config = function()
      require('conform').setup {
        notify_on_error = false,
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'ruff_format' },
          javascript = { 'prettierd' },
          javascriptreact = { 'prettierd' },
          typescript = { 'prettierd' },
          typescriptreact = { 'prettierd' },
        },
      }

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
