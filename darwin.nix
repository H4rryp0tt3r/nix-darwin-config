{ pkgs, gitRev, ... }: {
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = gitRev;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";

  # Config for users
  users.users.h4rryp0tt3r = {
    name = "h4rryp0tt3r";
    home = "/Users/h4rryp0tt3r";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    tree
    vim
    wget
    curl
    jq
    htop
    neofetch
    tmux
    git
    tig
    imgcat
  ];

  environment.variables = {
    GIT_REVISION = gitRev;
  };

  # Create /etc/zshrc that loads the nix-darwin environment
  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    taps = [];
    brews = [];
    casks = [];
  };

  # Enable Touch ID auth for sudo
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults.dock.autohide = true;
}
