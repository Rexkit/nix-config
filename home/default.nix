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
    inputs.hyprland.homeManagerModules.default
    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.nix-colors.homeManagerModules.default
    ../nixos/common/deploy_dots.nix
    ./features/xdg
    ./features/fonts
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
    light
    wl-clipboard
    wl-screenrec
    wlr-randr
    libnotify

    #system
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
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
