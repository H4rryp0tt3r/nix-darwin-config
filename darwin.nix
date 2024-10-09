{ pkgs, gitRev, ... }: {
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.config.allowUnfree = true;

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
    nixpkgs-fmt
  ];

  environment.variables = {
    GIT_REVISION = gitRev;
  };

  # Create /etc/zshrc that loads the nix-darwin environment
  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    taps = [ ];
    brews = [ ];
    casks = [
      "1password"
      "1password-cli"
      "iterm2"
      "raycast"
      "rectangle"
      "homerow"
      "lunar"
      "appcleaner"
      "firefox"
      "google-chrome"
      "iina"
      "zoom"
    ];

    masApps = {
      amphetamine = 937984704;
      wireguard = 1451685025;
      flycut = 442160987;
    };

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
  };

  # Enable Touch ID auth for sudo
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults.dock = {
    autohide = true;
    autohide-delay = 0.0;
    tilesize = 48;
    launchanim = false;
    static-only = false;
    showhidden = true;
    show-recents = false;
    show-process-indicators = true;
    mru-spaces = false;
    persistent-apps = [
      "/Applications/Firefox.app"
      "/Applications/iTerm.app"
      "/Users/h4rryp0tt3r/Applications/Home Manager Apps/Visual Studio Code.app" # TODO: Pass username from the calling site
    ];
    # Disable hot corners
    wvous-bl-corner = 1;
    wvous-br-corner = 1;
    wvous-tl-corner = 1;
    wvous-tr-corner = 1;
  };

  system.defaults.finder = {
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    FXDefaultSearchScope = "SCcf"; # Seach only current folder
    FXEnableExtensionChangeWarning = false;
    FXPreferredViewStyle = "icnv";
    QuitMenuItem = true;
    ShowStatusBar = true;
    _FXSortFoldersFirst = true;
  };

  system.defaults.NSGlobalDomain = {
    AppleInterfaceStyle = "Dark";
    AppleShowScrollBars = "Automatic";
    "com.apple.keyboard.fnState" = true;
  };

  system.defaults.trackpad.Clicking = true;

  system.defaults.screencapture = {
    location = "~/Desktop";
    type = "jpg";
  };

  system.defaults.CustomUserPreferences = {
    NSGlobalDomain = {
      # Add a context menu item for showing the Web Inspector in web views
      WebKitDeveloperExtras = true;
    };
    "com.apple.finder" = {
      ShowExternalHardDrivesOnDesktop = true;
      ShowMountedServersOnDesktop = true;
      ShowRemovableMediaOnDesktop = true;
    };
    "com.apple.desktopservices" = {
      # Avoid creating .DS_Store files on network or USB volumes
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
    "com.apple.AdLib" = {
      allowApplePersonalizedAdvertising = false;
    };
    "com.apple.print.PrintingPrefs" = {
      # Automatically quit printer app once the print jobs complete
      "Quit When Finished" = true;
    };
    "com.apple.SoftwareUpdate" = {
      AutomaticCheckEnabled = true;
      # Check for software updates daily, not just once per week
      ScheduleFrequency = 1;
      # Download newly available updates in background
      AutomaticDownload = 1;
      # Install System data files & security updates
      CriticalUpdateInstall = 1;
    };
    "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
    # Prevent Photos from opening automatically when devices are plugged in
    "com.apple.ImageCapture".disableHotPlug = true;
    # Turn on app auto-update
    "com.apple.commerce".AutoUpdate = true;
  };

  system.activationScripts.postUserActivation.text = ''
    # activateSettings -u will reload the settings from the database and
    # apply them to the current session, so we do not need to logout and
    # login again to make the changes take effect.
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
