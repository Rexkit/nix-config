{ pkgs, config, ... }: {
  colors = with config.colorScheme.colors; {
    primary = {
      background = "0x${base00}";
      foreground = "0x${base05}";
      dim_foreground = "0x${base05}";
      bright_foreground = "0x${base05}";
    };
    cursor = {
      text = "0x${base00}";
      cursor = "0x${base06}";
    };
    vi_mode_cursor = {
      text = "0x${base00}";
      cursor = "0x${base07}";
    };
    search = {
      matches = {
        foreground = "0x${base00}";
        background = "#A6ADC8";
      };
      focused_match = {
        foreground = "0x${base00}";
        background = "0x${base0B}";
      };
    };
    footer_bar = {
      foreground = "0x${base00}";
      background = "#A6ADC8";
    };
    hints = {
      start = {
        foreground = "0x${base00}";
        background = "0x${base0A}";
      };
      end = {
        foreground = "0x${base00}";
        background = "#A6ADC8";
      };
    };
    selection = {
      text = "0x${base00}";
      background = "0x${base06}";
    };
    normal = {
      black = "0x${base03}";
      red = "0x${base08}";
      green = "0x${base0B}";
      yellow = "0x${base0A}";
      blue = "0x${base0D}";
      magenta = "#F5C2E7";
      cyan = "0x${base0C}";
      white = "#BAC2DE";
    };
    bright = {
      black = "#585B70";
      red = "0x${base08}";
      green = "0x${base0B}";
      yellow = "0x${base0A}";
      blue = "0x${base0D}";
      magenta = "#F5C2E7";
      cyan = "0x${base0C}";
      white = "#A6ADC8";
    };
    dim = {
      black = "0x${base03}";
      red = "0x${base08}";
      green = "0x${base0B}";
      yellow = "0x${base0A}";
      blue = "0x${base0D}";
      magenta = "#F5C2E7";
      cyan = "0x${base0C}";
      white = "#BAC2DE";
    };
    indexed_colors = [
      {
        index = 17;
        color = "0x${base06}";
      }
      {
        index = 16;
        color = "0x${base09}";
      }
    ];
  };
}