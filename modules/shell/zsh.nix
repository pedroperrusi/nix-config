{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    defaultKeymap = "emacs";

    loginExtra = ''
      [ -f ~/.nix-profile/etc/profile.d/hm-session-vars.sh ] && source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    '';

    shellAliases = {
      ls  = "eza -lh --group-directories-first --icons=auto";
      lsa = "ls -a";
      lt  = "eza --tree --level=2 --long --icons --git";
      lta = "lt -a";
      n   = "nvim";
      ff  = ''fzf --preview 'bat --style=numbers --color=always {}' '';
      g   = "git";
      lg  = "lazygit";
      hm  = "home-manager switch --flake ~/nix-config#pedro@work-ubuntu";
    };

    initExtra = ''
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh

      # mise activation - tool version manager
      if command -v mise &> /dev/null; then
        eval "$(mise activate zsh)"
      fi
    '';
  };

  programs.fzf.enable = true;

  programs.eza = {
    enable = true;
    enableZshIntegration = false;
  };

  programs.zoxide.enable = true;
}
