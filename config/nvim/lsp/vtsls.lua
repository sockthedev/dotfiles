return {
  cmd = { 'vtsls', '--stdio' },
  root_markers = {
    'pnpm-workspace.yaml',
    'pnpm-lock.yaml',
    'package-lock.json',
    'yarn.lock',
    'bun.lockb',
    '.git',
  },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  workspace_required = true,
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
    },
    javascript = {
      preferences = {
        includePackageJsonAutoImports = 'off',
      },
      inlayHints = {
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    typescript = {
      tsserver = {
        maxTsServerMemory = 4096,
      },
      inlayHints = {
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    experimental = {
      completion = {
        entriesLimit = 3,
      },
    },
  },
}
