return {
  cmd = { 'pyright-langserver', '--stdio' },
  root_markers = {
    'pyproject.toml',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git',
  },
  workspace_required = true,
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
