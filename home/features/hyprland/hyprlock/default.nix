{pkgs, ...}: {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = false;
        hide_cursor = true;
        grace = 0;
        no_fade_in = false;
        no_fade_out = false;
        ignore_empty_input = false;
      };

      background = [
        {
          path = "~/.config/hypr/wallpapers/lockscreen.png";
          color = "rgba(30, 30, 46, 1.0)";
          blur_passes = 0;
          blur_size = 6;
          noise = 0.0115;
          contrast = 0.9000;
          brightness = 0.8500;
          vibrancy = 0.1500;
          vibrancy_darkness = 0.0;
        }
      ];

      input-field = [
        {
          size = 250, 50;
          outline_thickness = 4;
          dots_size = 0.35;
          dots_spacing = 0.25;
          dots_center = false;
          dots_rounding = -2;
          outer_color = "rgb(31, 30, 46)";
          inner_color = "rgb(31, 30, 46)";
          font_color = "rgb(186, 194, 222)";
          fade_on_empty = true;
          fade_timeout = 1000;
          placeholder_text = '\'<i>Enter Password</i>'\';
          hide_input = false;
          rounding = 24;
          check_color = "rgb(137, 180, 250)";
          fail_color = "rgb(243, 139, 168)";
          fail_text = '\'<i>$FAIL <b>($ATTEMPTS)</b></i>'\';
          fail_transition = 300;
          capslock_color = -1;
          numlock_color = -1;
          bothlock_color = -1;
          invert_numlock = false;
          swap_font_color = false;

          position = "0, -50";
          halign = "center";
          valign = "center";

          shadow_passes = 3;
          shadow_size = 6;
          shadow_color = "rgb(0, 0, 0)";
          shadow_boost = 0.50;
        }
      ];

      label = [
        {
          text = "$TIME";
          color = "rgb(186, 194, 222)";
          font_size = 48;
          font_family = "Iosevka Bold";

          position = "0, 300";
          halign = "center";
          valign = "center";

          shadow_passes = 3;
          shadow_size = 6;
          shadow_color = "rgb(0, 0, 0)";
          shadow_boost = 1.0;
        }
        {
          text = '\'Hi <span foreground="##F38BA8"> <b>$USER</b></span> '\';
          color = "rgb(186, 194, 222)";
          font_size = 24;
          font_family = "Iosevka";

          position = "0, 50";
          halign = "center";
          valign = "center";

          shadow_passes = 3;
          shadow_size = 6;
          shadow_color = "rgb(0, 0, 0)";
          shadow_boost = 0.50;
        }
        {
          text = '\'<span foreground="##F38BA8"></span>'\';
          color = rgb(186, 194, 222);
          font_size = 64;
          font_family = "Iosevka";

          position = "0, -450";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}