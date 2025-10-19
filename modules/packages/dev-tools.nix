{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vscode
    docker
    docker-compose
    uv
  ];

  home.sessionVariables = {
    # NVIDIA Docker runtime will be configured system-wide
    DOCKER_DEFAULT_PLATFORM = "linux/amd64";
  };
}
