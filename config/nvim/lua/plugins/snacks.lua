return {
  {
    'folke/snacks.nvim',
    opts = {
      -- bigfile adds a new filetype bigfile to Neovim that triggers when the file is larger than the configured size. This automatically prevents things like LSP and Treesitter attaching to the buffer.
      bigfile = {
        notify = true,
        size = 1.5 * 1024 * 1024, -- 1.5MB
      },
    },
  },
}
