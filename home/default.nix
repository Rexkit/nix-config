# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    inputs.sops-nix.homeManagerModules.sops
    inputs.hyprland.homeManagerModules.default
    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.nix-colors.homeManagerModules.default
    ../nixos/common/deploy_dots.nix
    ./features/xdg
    ./features/fonts
    ./features/zsh
    ./features/alacritty
    ./features/hyprland
    ./features/vsc
    ./features/floorp
    ./features/discord
    ./features/telegram
    ./features/remmina
    ./features/brave
    ./features/mpd
    ./features/mpv
  ];

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/nkuzin/.config/sops/age/keys.txt";

    secrets = {
      github_token = { };
    };
  };

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  gtk = {
    enable = true;

    font = {
      name = "Noto Sans 9";
    };
  };

  systemd.user.services.xdg-desktop-portal-hyprland.serviceConfig.PassEnvironment =
      [ "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP" "QT_QPA_PLATFORMTHEME" "PATH" ];

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # TODO: Set your username
  home = {
    username = "nkuzin";
    homeDirectory = "/home/nkuzin";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    #video
    vlc

    #editor
    geany

    # utils
    viewnior
    pulsemixer
    light
    grim
    swappy
    swaybg
    slurp
    wl-clipboard    
    wl-screenrec
    wlr-randr
    libnotify
    sops

    #system
    xdg-user-dirs
    freerdp3
    polkit_gnome
    xdg-desktop-portal-hyprland
    networkmanager_dmenu
    networkmanagerapplet
    (catppuccin-kvantum.override {
      accent = "Mauve";
      variant = "Mocha";
    })
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
  ];

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
    General.theme = "Catppuccin-Mocha-Mauve";
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName  = "Nikita Kuzin";
    userEmail = "ptznikko@gmail.com";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
