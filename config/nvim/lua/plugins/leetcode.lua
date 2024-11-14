return {

  {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('leetcode').setup {
        lang = 'kotlin', -- 'golang',
      }
    end,
  },
}
