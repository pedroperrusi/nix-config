{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Pedro Perrusi";
    userEmail = "pedro.perrusi@bbraun.com";
    
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.default = "current";
      diff.tool = "delta";
      interactive.diffFilter = "delta --color-only";
      delta = {
        navigate = true;
        line-numbers = true;
      };
    };
  };
}
