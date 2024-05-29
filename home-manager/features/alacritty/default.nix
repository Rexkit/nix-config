_: let
  catppuccin = import ./catppuccin.nix;
in {
  programs.alacritty = {
    enable = true;

    settings = {
      inherit (catppuccin) colors;

      font = {
        ## Font size in points.
        size = 10;

        ## When true, Alacritty will use a custom built-in font for box drawing characters and powerline symbols.
        builtin_box_drawing = true;

        normal = {
          family = "JetBrainsMono Nerd Font";
        };

        bold = {
          family = "JetBrainsMono Nerd Font";
        };

        italic = {
          family = "JetBrainsMono Nerd Font";
        };

        bold_italic = {
          family = "JetBrainsMono Nerd Font";
        };

        offset = {
          x = 0;
          y = 0;
        };

        glyph_offset = {
          x = 0;
          y = 0;
        };
      };
      
      window = {
        position = "None";
        dynamic_padding = true;
        decorations = "full";
        opacity = 1.0;
        blur = false;
        startup_mode = "Windowed";
        dynamic_title = true;
        class = "{ instance = 'Alacritty', general = 'Alacritty' }";
        decorations_theme_variant = "None";

        dimensions = {
          columns = 82;
          lines = 24;
        };

        padding = {
          x = 12;
          y = 12;
        };
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      selection = {
        save_to_clipboard = true;
      };

      cursor = {
        vi_mode_style = "None";
        blink_interval = 750;
        blink_timeout = 5;
        unfocused_hollow = false;
        thickness = 0.15;

        style = {
          shape = "Block";
          blinking = "On";
        };
      };

      mouse = {
        hide_when_typing = false;
      };
    };
  };
}