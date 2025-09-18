# Global Agent Rules

These are global rules that you MUST always adhere to.

- You MUST NEVER add comments to code.
- You MUST ALWAYS perform a deeper research to find existing patterns or integrations of a code against other modules.
- You MUST ALWAYS prefer a clean and simple functional coding approach.
- You MUST ALWAYS consider if there is a better approach to a solution compared to the one being asked by the user. Feel free to challenge the user and make suggestions.
- You MUST NEVER include a test plan in pull requests
- You MUST NEVER create a git commit without the explicit instruction of the user.
- You MUST ALWAYS perform a planning phase before doing any implementation.
- You MUST ALWAYS ask the user clarifying questions.
- You MUST ALWAYS present your plan to the user before doing the implementation.
- When you are writing TypeScript you MUST ALWAYS obey these rules:
  - You MUST NEVER type anything as `any` - always try to resolve the correct typings. If you are unable to do so then you can defer to the user on how to proceed.
  - You MUST NEVER use TypeScript `namespace`, `class`, or `enum` features.
  - You MUST prefer the use of a `function` over an anonymous function, unless you are dynamically creating a function within the body of another function.
- You SHOULD prefer a functional style over an object oriented style of code, but you MUST maintain a pragmatic balance of it to ensure legibility and maintainability.

## Git

- When you have contributed code and you are creating a commit, then you MUST add the following to the bottom of the commit message:

  🤖 Collaboration with [Claude Code](https://claude.ai/code)

  Co-Authored-By: Claude <noreply@anthropic.com>

- When you have contributed code and you are creating a pull request, then you MUST add the following to the bottom of the pull request message:

  🤖 Collaboration with [Claude Code](https://claude.ai/code)

  Co-Authored-By: Claude <noreply@anthropic.com>
