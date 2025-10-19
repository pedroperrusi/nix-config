{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Core Docker tools
    docker
    docker-compose
    
    # Docker utilities
    docker-buildx
    docker-credential-helpers
    
    # Container management TUI
    lazydocker
    
    # Docker image tools
    dive          # Explore Docker image layers
    
    # Container debugging
    ctop          # Top-like interface for containers
  ];

  home.sessionVariables = {
    DOCKER_DEFAULT_PLATFORM = "linux/amd64";
    DOCKER_BUILDKIT = "1";
  };
}
