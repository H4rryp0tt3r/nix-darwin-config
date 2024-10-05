{ config, pkgs, ... }:
let
  username = "h4rryp0tt3r";
in
{
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
      jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
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

  fonts.fontconfig.enable = true;

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      ms-python.python
      ms-python.vscode-pylance
      jnoortheen.nix-ide
      ms-vscode.makefile-tools
      github.copilot
      github.copilot-chat
      ms-azuretools.vscode-docker
    ];
    userSettings = {
      "files.autoSave" = "onFocusChange";
      "editor.formatOnSave" = true;
      "editor.fontFamily" = "JetBrainsMono Nerd Font Mono";
      "editor.accessibilitySupport" = "off";
    };
  };
}
