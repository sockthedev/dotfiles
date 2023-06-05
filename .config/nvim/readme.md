# sockthedev's Neovim config

Neovim is so frikken fun. I can't believe how hard I've been bitten by this bug. This repository is my personal configuration for it.

To install;

```bash
git clone https://github.com/sockthedev/init.lua
cd init.lua
./install
```

## Dependencies

The following dependencies are required;

```bash
brew install cmake
brew install make
brew install pkg-config
brew install luarocks
brew install fzf
brew install ripgrep
brew install gsed
brew install ncurse
brew install tmux
brew install wezterm
```

Then make sure Neovim is installed;

```bash
brew install neovim
```

## Keymaps

To make the keyboard much more pleasant to use install Karabiner Elements;

```bash
brew install karabiner-elements
```

And then make sure the following are configured;

- "Change caps_lock to left_control if pressed with other keys, change caps_lock to escape if pressed alone."

  You will need to import this from the website via the "Complex Modifications" section.

- "Change right_command+hjkl to arrow keys"

  This is by default bundles with Karabiner, you can add the rule via the "Complex Modifications" section.

## Terminal

I highly recommend the usage of iTerm2.

```bash
brew install iterm2
```
## tmux

For MacOS may [need this fix tmux-256color](https://stackoverflow.com/a/74042519).

## References

My config is mostly a process of copying configuration from the following repositories;

- https://github.com/LunarVim/LunarVim
- https://github.com/craftzdog/dotfiles-public
- https://github.com/LazyVim/LazyVim
- https://github.com/MunifTanjim/dotfiles
- https://github.com/adamelmore/dotfiles
- https://github.com/josean-dev/dev-environment-files
- https://github.com/mhartington/dotfiles
