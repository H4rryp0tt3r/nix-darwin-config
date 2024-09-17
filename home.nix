{ config, pkgs, ... }: let
username = "h4rryp0tt3r";
in {
  home = {
    inherit username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.05";
    sessionPath = ["/usr/local/sbin"];

    packages = with pkgs; [
      git
      tree
      wireguard-tools
      android-tools
      nixpkgs-fmt
      tmux
      qrencode
      tig
    ];

    sessionVariables = {
      EDITOR = "vim";
      SHELL = "zsh";
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
