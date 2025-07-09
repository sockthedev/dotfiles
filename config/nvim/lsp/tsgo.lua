return {
  cmd = { 'tsgo', '--lsp', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  root_markers = require('lspconfig').util.root_pattern(
    'pnpm-lock.yaml',
    'package-lock.json',
    'yarn.lock',
    'bun.lockb',
    '.git'
  ),
  single_file_support = false,
  -- Add any specific settings the tsgo LSP might need
}
