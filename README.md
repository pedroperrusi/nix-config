# Nix Configuration - Modular Home Manager Setup

A clean, modular Home Manager configuration for managing your development environment with Nix.

## 🧱 Philosophy

Focus on small, composable modules instead of a giant monolith. Each concern (shell, programs, packages, scripts) lives in its own file and is imported by a single machine profile under `home/`. This keeps diffs tiny and onboarding fast.

## 🗺 Architecture Overview

```text
flake.nix                # Entrypoint: pins channels & exposes homeConfigurations
home/work-ubuntu.nix     # Machine profile: imports module tree
modules/
    shell/                 # Shell related config (zsh, starship, direnv)
    programs/              # Managed apps with declarative settings
    packages/              # Grouped package sets (cli, tui, dev-tools, fonts, utilities)
    desktop/               # Desktop integration & XDG entries
    scripts/               # Small helper or setup scripts packaged via HM
```

## 🔐 Reproducibility

- Channels pinned via `flake.nix` (`nixos-24.05`, `nixos-unstable` for select packages).
- Avoids ad‑hoc installs; everything flows through Home Manager.
- To refresh inputs:

```bash
nix flake update
home-manager switch --flake .#pedro@work-ubuntu
```

- For experimental or binary-only tools (e.g. OpenCode) hash pinning is used; migrate to tagged release when available.

## 🧠 AI & Coding Assistance

### OpenCode (Terminal AI Agent)

Integrated via `modules/packages/dev-tools/opencode.nix`, currently fetching the latest archived binary:

```nix
version = "latest";
sha256  = "09c0r7aa9vwgfpmpq43v19nqrkp96k9ic8iyiz2aw83r7qh427vz";
```text

Next improvement: replace `latest` with final release tag once confirmed upstream. Wrapper & XDG cache support can be added if runtime writes become problematic under Nix.

### GitHub Copilot CLI / gh-copilot

Included under `cli-tools.nix` for quick inline AI assistance.

## 🛠 Development Tooling Modules

| Module | Purpose |
|--------|---------|
| `dev-tools/vscode.nix` | GUI editor from unstable channel |
| `dev-tools/opencode.nix` | Terminal AI coding agent binary derivation |
| `dev-tools/docker.nix` | Docker + compose + debugging utilities |
| `dev-tools/python.nix` | Python ecosystem (uv, pyenv, ruff, mypy, black) |

## 🧪 Common Workflows

```bash
# Switch to current configuration
home-manager switch --flake ~/nix-config#pedro@work-ubuntu

# Preview activation without applying
nix build .#homeConfigurations.pedro@work-ubuntu.activationPackage

# Inspect generated result symlink
ls -l result

# Update inputs
nix flake update

# Query package closure size (example)
nix path-info -Sh $(which opencode)

# Run OpenCode
opencode help
```

## 🧩 Adding a New Module

1. Create file under `modules/...`
2. Export either `home.packages`, `programs.<tool>`, or `xdg.configFile` entries.
3. Import it in `home/work-ubuntu.nix`.
4. Switch: `home-manager switch --flake .#pedro@work-ubuntu`.

## 🐛 Troubleshooting

| Symptom | Fix |
|---------|-----|
| "Path not tracked by Git" during switch | `git add <file>` so flake can evaluate it |
| Hash mismatch on binary fetch | Re-run `nix-prefetch-url <asset-url>` and update sha256 |
| Runtime tool writes denied | Add wrapper with XDG vars or use `home.file` for config |
| Ghostty fails to start with GL | Install `nixGL` or adjust `LD_LIBRARY_PATH` in wrapper |

## 🗃 Future Improvements

- Pin OpenCode to final release tag & optionally build from source for static binary.
- Add `modules/README.md` generated from file headers.
- Introduce CI (flake check, formatting, dead hash scanning).
- Mac profile once hardware arrives (`pedro@mac`).
