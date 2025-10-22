# Dotfiles Integration

This Nix configuration integrates with a separate dotfiles repository for frequently-changed configs.

## Architecture

```
~/nix-config/              # System & package configuration (this repo)
├── flake.nix
├── modules/
│   ├── packages/          # What packages to install
│   ├── programs/          # Program configurations
│   └── shell/

~/dotfiles/                # Frequently-edited configs (separate repo)
├── nvim/                  # Neovim config (lazy.nvim manages plugins)
└── tmux/                  # Tmux config (keybindings, theme)
```

## Why Split?

**Nix Config** - For things that need Home Manager rebuild:

- Package installations
- System integrations
- Machine-specific settings (git email, paths)
- Static configs (Git, Zsh, Ghostty)

**Dotfiles** - For things that benefit from quick iteration:

- Neovim plugins and config (lazy.nvim manages them)
- Tmux keybindings (learn and adjust)
- Any config you frequently experiment with

## How It Works

### Neovim

```nix
# modules/programs/neovim.nix
xdg.configFile."nvim" = {
  source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
  recursive = true;
};
```

- Nix creates symlink: `~/.config/nvim` → `~/dotfiles/nvim`
- Edit `~/dotfiles/nvim/init.lua` → Changes active immediately
- Add plugins via lazy.nvim (no Nix rebuild needed)

### Tmux

```nix
# modules/programs/tmux.nix
extraConfig = builtins.readFile "${config.home.homeDirectory}/dotfiles/tmux/tmux.conf";
```

- Nix reads config from `~/dotfiles/tmux/tmux.conf`
- Edit config → Press `Ctrl+a R` to reload
- No Home Manager rebuild needed for keybinding changes

## Setup

### Initial Setup

```bash
# Clone dotfiles (already done)
cd ~/dotfiles
git remote add origin git@github.com:pedroperrusi/dotfiles.git
git push -u origin main

# Rebuild Nix config to create symlinks
cd ~/nix-config
home-manager switch --flake .
```

### Daily Workflow

```bash
# Edit Neovim config
cd ~/dotfiles/nvim
nvim init.lua
# Save and restart nvim - changes applied!

# Edit Tmux config
cd ~/dotfiles/tmux
nvim tmux.conf
# In tmux: Ctrl+a R to reload

# Commit changes
git add -A
git commit -m "Update keybindings"
git push
```

## Benefits

✅ **No rebuild needed** - Edit configs, changes apply immediately
✅ **Single source of truth** - No duplication between Nix and config files
✅ **Version controlled** - Both repos tracked in Git
✅ **Portable** - Dotfiles work on non-NixOS systems too
✅ **Fast iteration** - Try plugins/keybindings instantly

## What Stays in Nix?

Keep these in `~/nix-config`:

- Git config (machine-specific email/name)
- Zsh config (path interpolation, machine-specific aliases)
- Ghostty, Btop, Rofi (simple, static configs)
- Package declarations

## Dotfiles Repository

See `~/dotfiles/README.md` for details on Neovim and Tmux configurations.
