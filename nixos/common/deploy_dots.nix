{ pkgs, lib, config, hostname, ... }:
{
  home.file."${config.xdg.configHome}/rofi" = {
    source = ../.. + "/common" + /rofi;
    recursive = true;
  };

  # home.file."${config.xdg.configHome}/" = {
  #   source = ../../.. + "/${hostname}" + /;
  #   recursive = true;
  # };
}