{ pkgs, ... }:

with import <nixpkgs> {};
with builtins;
with lib;

{
  # Import other config files
  imports = [
    ./config/beets/beets.nix
    ./config/fish/fish.nix
    ./config/mako/mako.nix
    ./config/mpd/mpd.nix
    ./config/ncmpcpp/ncmpcpp.nix
    ./config/neovim/neovim.nix
    ./config/sway/sway.nix
    ./config/tmux/tmux.nix
    ./config/waybar/waybar.nix
    ./config/xdg/xdg.nix
  ];

  # Packages to install
  home.packages = with pkgs; [

    # Import package entries from other files
    (callPackage ./packages/st/st.nix {})

    # Languages
    nodejs
    python3Minimal

    # Programs
    discord
    lutris
    mpd
    mpv
    neofetch

    # Utilities
    grim
    mpc_cli
    slurp
    sway-contrib.grimshot
    wdisplays
    wl-clipboard
    wofi
    youtube-dl

    # Fonts
    dina-font
    fira-code
    fira-code-symbols
    font-awesome
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    ubuntu_font_family
  ];

  # Allow proprietary software
  nixpkgs.config.allowUnfree = true;

  # Enable discovery of fonts from installed packages
  fonts.fontconfig.enable = lib.mkForce true;

  # Configure GTK
  gtk = {

    # Enable GTK customisation
    enable = true;

    # Set theme
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    
    # Set icon theme
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  # Configure programs
  programs = {

    # Enable fuzzy-file-finder
    fzf.enable = true;

    # Configure git
    git = {
      enable = true;
      userName  = "ashe";
      userEmail = "git@aas.sh";
    };
  };

  # Configure services
  services = {

    # Enable dropbox
    dropbox = {
      enable = true;
    };

    # Enable gammastep
    gammastep = {
      enable = true;
      provider = "geoclue2";
      tray = true;
    };
  };
}
