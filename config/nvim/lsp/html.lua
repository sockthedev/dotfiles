return {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = {
    'html',
    'blade',
    'javascriptreact',
    'typescriptreact',
    'svelte',
  },
  root_markers = { 'index.html', '.git' },
  settings = {
    html = {
      init_options = { provideFormatter = true },
    },
  },
}
