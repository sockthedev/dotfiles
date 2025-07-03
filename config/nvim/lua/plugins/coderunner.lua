return {
  'CRAG666/code_runner.nvim',
  dependencies = {
    {
      'CRAG666/betterTerm.nvim',
      opts = {
        position = 'bot',
        size = 15,
      },
    },
  },
  opts = {
    -- mode = 'toggleterm',
    filetype = {
      go = 'go run',
      typescript = 'bun run',
    },
  },
}
