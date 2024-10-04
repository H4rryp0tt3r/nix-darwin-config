{ config, pkgs, ... }: let
username = "h4rryp0tt3r";
in {
  home = {
    inherit username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.05";

    packages = with pkgs; [
      wireguard-tools
      android-tools
      qrencode
      colima
      docker
      docker-compose
      docker-buildx
      imagemagick
    ];

    sessionVariables = {
      EDITOR = "vim";
      SHELL = "zsh";
      DOCKER_HOST = "unix://$HOME/.colima/docker.sock";
    };
  };

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "z" ];
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "Nagesh Podilapu";
    userEmail = "nagesh.podilapu@gmail.com";
    ignores = [ ".DS_Store" ];
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  programs.vim = {
    enable = true;
    extraConfig = ''
      set number
      syntax on
    '';
  };
}
