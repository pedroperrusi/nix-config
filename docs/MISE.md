# mise Setup

mise (pronounced "meez") is a polyglot tool version manager and task runner that has been integrated into this Nix configuration.

## What is mise?

mise is a modern alternative to tools like asdf, nvm, pyenv, etc. It allows you to:

- Manage multiple versions of programming languages and tools
- Set project-specific tool versions
- Define and run tasks
- Manage environment variables per project

## Installation

mise is automatically installed and activated through your Nix home-manager configuration.

After running `home-manager switch`, mise will be available in your shell.

## Basic Usage

### Install and use tools

```bash
# Install a specific version of a tool globally
mise use --global node@20
mise use --global python@3.11

# Install a tool for the current project (creates/updates .mise.toml)
mise use node@20
mise use python@3.11

# List installed tools
mise list

# List available versions for a tool
mise ls-remote node
```

### Run commands with specific tools

```bash
# Execute a command with a specific tool version
mise exec node@20 -- node --version
mise exec python@3.11 -- python --version
```

### Define and run tasks

Create a `mise.toml` in your project:

```toml
[tools]
node = "20"
python = "3.11"

[env]
NODE_ENV = "development"

[tasks.dev]
run = "npm run dev"
description = "Start development server"

[tasks.test]
run = "pytest"
description = "Run tests"
```

Then run tasks:

```bash
mise run dev
mise run test
```

### Configuration

mise can be configured at multiple levels:

- **Global**: `~/.config/mise/config.toml`
- **Project**: `<project>/.mise.toml`
- **Local override**: `<project>/.mise.local.toml` (gitignored)

### Integration with direnv

mise works seamlessly with direnv (already configured in this setup). When you have both:

- mise manages tool versions
- direnv can use mise to automatically activate environments

Add to your `.envrc`:

```bash
use mise
```

## Useful Commands

```bash
mise doctor          # Check mise installation
mise --version       # Show mise version
mise list            # List installed tools
mise outdated        # Show outdated tools
mise upgrade         # Upgrade mise itself
mise prune           # Remove unused tool versions
mise trust           # Trust a config file in the current directory
```

## Documentation

- [Official Documentation](https://mise.jdx.dev/)
- [Getting Started Guide](https://mise.jdx.dev/getting-started.html)
- [Configuration Reference](https://mise.jdx.dev/configuration.html)

## GitHub Token (Optional)

Many tools in mise use the GitHub API. To avoid rate limiting, set a GitHub token:

```bash
export MISE_GITHUB_TOKEN=ghp_your_token_here
# or
export GITHUB_TOKEN=ghp_your_token_here
```

Generate a token at: <https://github.com/settings/tokens/new?description=MISE_GITHUB_TOKEN>

## Examples

### Python Project

```toml
# .mise.toml
[tools]
python = "3.11"

[env]
VIRTUAL_ENV = ".venv"
```

### Node.js Project

```toml
# .mise.toml
[tools]
node = "20"

[tasks.install]
run = "npm install"

[tasks.dev]
run = "npm run dev"
```

### Multi-language Project

```toml
# .mise.toml
[tools]
node = "20"
python = "3.11"
go = "1.21"
rust = "latest"

[tasks.setup]
run = """
npm install
pip install -r requirements.txt
"""
```
