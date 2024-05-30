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
    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.nix-colors.homeManagerModules.default
    ./features/fonts
    ./features/alacritty
    ./features/hyprland
    ./features/vsc
    ./features/floorp
    ./features/discord
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

  # TODO: Set your username
  home = {
    username = "nkuzin";
    homeDirectory = "/home/nkuzin";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    # utils
    wl-clipboard
    wl-screenrec
    wlr-randr
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
