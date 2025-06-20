# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

This repository contains the configuration files for various tools I use in my development workflow.

- Terminal: ghostty
- Shell: zsh
- Editor: neovim

## Build & Test Commands

- Format code: `:Format` (or `<leader>cf` in normal mode)
- Toggle auto-format: `:FormatToggle`
- Format range: `:FormatRange` (in visual mode)
- Check TypeScript: Use tsc.nvim plugin commands

## Code Style Guidelines

- **Indentation**: 2 spaces, no tabs
- **Line Length**: 80 character maximum
- **Formatters**:
  - TS/JS/JSON/HTML: Prettier via prettierd
  - Lua: StyLua
  - Go: goimports
  - Python: ruff_format
- **Imports**: Group imports by standard lib, third-party, local
- **Naming**: Use camelCase for JS/TS, snake_case for Python/Lua
- **Error Handling**: Use LSP diagnostics features

## Editor Configuration

- Editor: Neovim with lazy.nvim plugin manager
- Key mappings follow conventions in keys.lua
- AI tools: Copilot and parrot.nvim (Claude, Gemini, OpenAI)
- File organization follows standard lazy.nvim structure

