return {
  root_dir = require('lspconfig').util.root_pattern(
    'pyproject.toml',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git'
  ),
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
      },
    },
  },
}
