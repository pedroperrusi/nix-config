{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Modern Python package manager
    uv
    
    # Python version management
    pyenv
    
    # Virtual environment tools
    virtualenv
    pipx
    
    # Code quality and formatting
    ruff
    black
    
    # Type checking
    mypy
    
    # Project scaffolding
    cookiecutter
    
    # Debugging
    python3Packages.ipython
    python3Packages.ipdb
  ];

  home.sessionVariables = {
    # Let uv manage Python versions
    UV_PYTHON_INSTALL_DIR = "$HOME/.local/share/uv/python";
  };
}
