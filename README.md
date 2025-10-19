# Nix Configuration - Modular Home Manager Setup

A clean, modular Home Manager configuration for managing your development environment with Nix.

## 📁 Structure

```
nix-config/
├── flake.nix                    # Main flake configuration
├── home/
│   └── work-ubuntu.nix          # Machine-specific config (imports modules)
└── modules/
    ├── shell/                   # Shell environment
    │   ├── zsh.nix
    │   ├── starship.nix
    │   └── direnv.nix
    ├── programs/                # Configured applications
    │   ├── git.nix
    │   └── neovim.nix
    └── packages/                # Package lists
        ├── cli-tools.nix
        ├── tui-tools.nix
        └── utilities.nix
```

## 🚀 Quick Start

### Apply Configuration

```bash
home-manager switch --flake ~/nix-config#pedro@work-ubuntu

# Or use the built-in alias after first run:
hm
```

### Update All Packages

```bash
cd ~/nix-config
nix flake update
hm
```

## 📚 Documentation

- **[MODULES_README.md](MODULES_README.md)** - Comprehensive guide with examples
- **[ARCHITECTURE.md](ARCHITECTURE.md)** - Visual structure and design patterns
- **[QUICK_REFERENCE.md](QUICK_REFERENCE.md)** - Cheat sheet for common tasks

## ✨ Features

- **Modular**: Each tool/program in its own file
- **Reusable**: Share modules across multiple machines
- **Maintainable**: Small, focused configurations
- **Version-controlled**: Everything in git, reproducible builds

## 🔧 Common Tasks

| Task | File to Edit |
|------|--------------|
| Add package | `modules/packages/{cli-tools,tui-tools,utilities}.nix` |
| Add shell alias | `modules/shell/zsh.nix` |
| Configure git | `modules/programs/git.nix` |
| Configure neovim | `modules/programs/neovim.nix` |

## 📦 What's Included

### Shell Environment
- **ZSH** with completions, autosuggestions, syntax highlighting
- **Starship** prompt
- **Direnv** for project-specific environments

### Development Tools
- **Git** with delta diff viewer
- **Neovim** with telescope, treesitter, lualine, and more
- **LazyGit** for terminal git UI

### CLI Utilities
- Modern replacements: `eza` (ls), `bat` (cat), `ripgrep` (grep), `fd` (find)
- Navigation: `fzf`, `zoxide`
- Monitoring: `htop`, `btop`
- Utilities: `jq`, `tree`, `tealdeer`

## 🎯 Next Steps

1. Read [MODULES_README.md](MODULES_README.md) for detailed usage
2. Customize modules to your preferences
3. Add new modules for additional tools
4. Create configurations for other machines

---

**Old Configuration**: Saved as `home/work-ubuntu.nix.backup` (can be deleted after verifying the new setup works)

Nix-based Home Manager configuration for managing packages and dotfiles.
