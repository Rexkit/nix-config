{ inputs, pkgs, lib, config, ... }: {
  imports = [
    ./mako
    ./rofi
    ./waybar
  ];

  xdg.portal = let
    hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xdph = pkgs.xdg-desktop-portal-hyprland.override {inherit hyprland;};
  in {
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      xdph
    ];
    configPackages = [hyprland];
  };

  home.packages = with pkgs; [
    (writeShellScriptBin "autostart" ''
      # Mako (Notifications)
      pkill mako
      mako &

      # Others
      /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
    '')

    (writeShellScriptBin "alacritty_script" ''
      if [ "$1" == "-f" ]; then
        alacritty --class 'alacritty-float,alacritty-float'
      elif [ "$1" == "-F" ]; then
        alacritty --class 'alacritty-fullscreen,alacritty-fullscreen' \
              -o window.startup_mode="'Fullscreen'" \
              window.padding.x=30 window.padding.y=30 \
              window.opacity=0.95 font.size=14
      else
        alacritty
      fi
    '')
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    systemd.enable = true;
    systemd.variables = ["--all"];

    settings = {
      monitor = ",preferred,auto,auto";

      "$notifycmd" = "notify-send -h string:x-canonical-private-synchronous:hypr-cfg -u low";

      # Elements
      "$hypr_border_size" = 4;
      "$hypr_gaps_in" = 10;
      "$hypr_gaps_out" = 20;
      "$hypr_gaps_ws" = -20;
      "$hypr_rounding" = 12;
      "$groupbar_font_family" = "Iosevka";
      "$groupbar_font_size" = 10;

      # Colors
      "$gradient_angle" = "45deg";
      "$active_border_col_1" = "0xFF89B4FA";
      "$active_border_col_2" = "0xFFF38BA8";
      "$inactive_border_col_1" = "0xFF28283d";
      "$inactive_border_col_2" = "0xFF32324d";
      "$active_shadow_col" = "0x66000000";
      "$inactive_shadow_col" = "0x66000000";
      "$group_border_active_col" = "0xFFA6E3A1";
      "$group_border_inactive_col" = "0xFFF9E2AF";
      "$group_border_locked_active_col" = "0xFFF38BA8";
      "$group_border_locked_inactive_col" = "0xFF89B4FA";
      "$groupbar_text_color" = "0xFFCDD6F4";

      general = {
        border_size = "$hypr_border_size";
        no_border_on_floating = false;
        gaps_in = "$hypr_gaps_in";
        gaps_out = "$hypr_gaps_out";
        gaps_workspaces = "$hypr_gaps_ws";
        "col.active_border" = "$active_border_col_1 $active_border_col_2 $gradient_angle";
        "col.inactive_border" = "$inactive_border_col_1 $inactive_border_col_2 $gradient_angle";
        "col.nogroup_border" = "$group_border_col";
        "col.nogroup_border_active" = "$group_border_active_col";
        layout = "dwindle";
        no_focus_fallback = false;
        apply_sens_to_raw = false;
        resize_on_border = true;
        extend_border_grab_area = 15;
        hover_icon_on_border = true;
        allow_tearing = false;
      };

      cursor = {
        no_warps = false;
        inactive_timeout = 30;
      };

      decoration = {
        rounding = "$hypr_rounding";
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;
        drop_shadow = true;
        shadow_range = 25;
        shadow_render_power = 3;
        shadow_ignore_window = false;
        "col.shadow" = "$active_shadow_col";
        "col.shadow_inactive" = "$inactive_shadow_col";
        shadow_offset = "0 0";
        shadow_scale = 1;
        dim_inactive = false;
        dim_strength = 0.5;
        dim_special = 0.2;
        dim_around = 0.4;
        blur = {
          enabled = false;
          size = 8;
          passes = 1;
          ignore_opacity = false;
          new_optimizations = true;
          xray = false;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
          special = true;
          popups = false;
          popups_ignorealpha = 0.2;
        };
      };

      animations = {
        enabled = true;
        first_launch_animation = true;
        animation = [
          "windowsIn,1,5,default,popin 0%"
          "windowsOut,1,5,default,popin"
          "windowsMove,1,5,default,slide"
          "fadeIn,1,8,default"
          "fadeOut,1,8,default"
          "fadeSwitch,1,8,default"
          "fadeShadow,1,8,default"
          "fadeDim,1,8,default"
          "border,1,10,default"
          "borderangle,1,10,default"
          "workspaces,1,5,default,slide"
          "specialWorkspace,1,5,default,fade"
        ];
        # animation = "windowsIn,1,5,default,popin 0%";
        # animation = "windowsOut,1,5,default,popin";
        # animation = "windowsMove,1,5,default,slide";
        # animation = "fadeIn,1,8,default";
        # animation = "fadeOut,1,8,default";
        # animation = "fadeSwitch,1,8,default";
        # animation = "fadeShadow,1,8,default";
        # animation = "fadeDim,1,8,default";
        # animation = "border,1,10,default";
        # animation = "borderangle,1,10,default";
        # animation = "workspaces,1,5,default,slide";
        # animation = "specialWorkspace,1,5,default,fade";
      };

      input = {
        kb_layout = "us,ru";
        kb_options = grp:alt_shift_toggle;
        numlock_by_default = false;
        repeat_rate = 25;
        repeat_delay = 600;
        sensitivity = 1.0;
        accel_profile = "adaptive";
        force_no_accel = true;
        left_handed = false;
        scroll_method = "2fg";
        scroll_button = 0;
        scroll_button_lock = 0;
        natural_scroll = false;
        follow_mouse = 1;
        mouse_refocus = true;
        float_switch_override_focus = 1;
        touchpad = {
          disable_while_typing = true;
          natural_scroll = false;
          scroll_factor = 1.0;
          middle_button_emulation = false;
          tap_button_map = "";
          clickfinger_behavior = false;
          tap-to-click = true;
          drag_lock = false;
          tap-and-drag = true;
        };
        touchdevice = {
          transform = 0;
        };
        tablet = {
          transform = 0;
          region_position = "0 0";
          region_size = "0 0";
          relative_input = false;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_distance = 300;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = true;
        workspace_swipe_direction_lock = true;
        workspace_swipe_direction_lock_threshold = 10;
        workspace_swipe_forever = false;
        workspace_swipe_use_r = false;
      };

      group = {
        insert_after_current = true;
        focus_removed_window = true;
        "col.border_active" = "$group_border_active_col";
        "col.border_inactive" = "$group_border_inactive_col";
        "col.border_locked_active" = "$group_border_locked_active_col";
        "col.border_locked_inactive" = "$group_border_locked_inactive_col";

        groupbar = {
          enabled = true;
          font_family = "$groupbar_font_family";
          font_size = "$groupbar_font_size";
          gradients = true;
          priority = 3;
          render_titles = true;
          scrolling = true;
          text_color = "$groupbar_text_color";
          "col.active" = "$group_border_active_col";
          "col.inactive" = "$group_border_inactive_col";
          "col.locked_active" = "$group_border_locked_active_col";
          "col.locked_inactive" = "$group_border_locked_inactive_col";
        };
      };

      binds = {
        pass_mouse_when_bound = false;
        scroll_event_delay = 300;
        workspace_back_and_forth = false;
        allow_workspace_cycles = false;
        workspace_center_on = 0;
        focus_preferred_method = 0;
        ignore_group_lock = false;
        movefocus_cycles_fullscreen = true;
      };

      xwayland = {
        use_nearest_neighbor = true;
        force_zero_scaling = false;
      };

      opengl = {
        nvidia_anti_flicker = true;
      };

      dwindle = {
        pseudotile = false;
        force_split = 0;
        preserve_split = false;
        smart_split = false;
        smart_resizing = true;
        permanent_direction_override = false;
        special_scale_factor = 0.8;
        split_width_multiplier = 1.0;
        no_gaps_when_only = false;
        use_active_for_splits = true;
        default_split_ratio = 1.0;
      };

      windowrule = [
        "float, foot-float|alacritty-float"
        "float, yad|nm-connection-editor|pavucontrolk"
        "float, xfce-polkit|kvantummanager|qt5ct"
        "float, feh|Viewnior|Gpicview|Gimp|MPlayer"
        "float, VirtualBox Manager|qemu|Qemu-system-x86_64"
        "float, title:File Operation Progress"
        "float, title:Confirm to replace files"

        "float, Yad|yad"
        "size 60% 64%, Yad|yad"

        "size 60% 64%, Viewnior"
        "center, Viewnior"

        "animation slide down,foot-full"
        "animation slide up,wlogout"
      ];

      "$rofi_launcher" = "~/.config/rofi/scripts/rofi_launcher";
      "$rofi_runner" = "~/.config/rofi/scripts/rofi_runner";
      "$rofi_music" = "~/.config/rofi/scripts/rofi_music";
      "$rofi_network" = "networkmanager_dmenu";
      "$rofi_bluetooth" = "~/.config/rofi/scripts/rofi_bluetooth";
      "$rofi_powermenu" = "~/.config/rofi/scripts/rofi_powermenu";
      "$rofi_screenshot" = "~/.config/rofi/scripts/rofi_screenshot";
      "$rofi_asroot" = "~/.config/rofi/scripts/rofi_asroot";

      "$editor" = "alacritty_script";

      bind = [
        "SUPER, D,       exec, $rofi_launcher"
        "ALT, F1,        exec, $rofi_launcher"
        "ALT, F2,        exec, $rofi_runner"  
        "SUPER, R,       exec, $rofi_asroot"    
        "SUPER, M,       exec, $rofi_music"    
        "SUPER, N,       exec, $rofi_network"    
        "SUPER, B,       exec, $rofi_bluetooth"  
        "SUPER, X,       exec, $rofi_powermenu" 
        "SUPER, A,       exec, $rofi_screenshot"
        "SUPER,       Return, exec, $editor"
        "SUPER_SHIFT, Return, exec, $editor -f"
        "SUPER,       T,      exec, $editor -F"

        "SUPER_SHIFT, W, exec, floorp"
        "SUPER_SHIFT, F, exec, thunar"

        "SUPER,       Q,      killactive,"
        "SUPER,       C,      killactive,"
        "CTRL_ALT,    Delete, exit,"
        "SUPER,       F,      fullscreen, 0"
        "SUPER,       F,      exec, $notifycmd 'Fullscreen Mode'"
        "SUPER,       S,      pseudo,"
        "SUPER,       S,      exec, $notifycmd 'Pseudo Mode'"
        "SUPER,       Space,  togglefloating,"
        "SUPER,       Space,  centerwindow,"

        # Change Focus
        "SUPER, left,  movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up,    movefocus, u"
        "SUPER, down,  movefocus, d"

        # Move Active
        "SUPER_SHIFT, left,  movewindow, l"
        "SUPER_SHIFT, right, movewindow, r"
        "SUPER_SHIFT, up,    movewindow, u"
        "SUPER_SHIFT, down,  movewindow, d"

        # Switch between windows
        "SUPER,Tab,cyclenext,"
        "SUPER,Tab,bringactivetotop,"

        # Workspaces
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"

        # Send to Workspaces
        "SUPER_SHIFT, 1, movetoworkspace, 1"
        "SUPER_SHIFT, 2, movetoworkspace, 2"
        "SUPER_SHIFT, 3, movetoworkspace, 3"
        "SUPER_SHIFT, 4, movetoworkspace, 4"
        "SUPER_SHIFT, 5, movetoworkspace, 5"
        "SUPER_SHIFT, 6, movetoworkspace, 6"
        "SUPER_SHIFT, 7, movetoworkspace, 7"
        "SUPER_SHIFT, 8, movetoworkspace, 8"

        # Seamless Workspace Switching
        "CTRL_ALT, left, workspace, e-1"
        "CTRL_ALT, right, workspace, e+1"
        "CTRL_ALT_SHIFT, left, movetoworkspace, e-1"
        "CTRL_ALT_SHIFT, right, movetoworkspace, e+1"

        # Change Workspace Mode
        "SUPER_CTRL, F, workspaceopt, allfloat"
        "SUPER_CTRL, S, workspaceopt, allpseudo"
      ];

      binde = [
        # Resize Active
        "SUPER_CTRL, left,  resizeactive, -20 0"
        "SUPER_CTRL, right, resizeactive, 20 0"
        "SUPER_CTRL, up,    resizeactive, 0 -20"
        "SUPER_CTRL, down,  resizeactive, 0 20"

        # Move Active (Floating Only)
        "SUPER_ALT, left,  moveactive, -20 0"
        "SUPER_ALT, right, moveactive, 20 0"
        "SUPER_ALT, up,    moveactive, 0 -20"
        "SUPER_ALT, down,  moveactive, 0 20"
      ];

      bindm = [
        #Mouse Buttons
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      bindr = [
        "SUPER, SUPER_L, exec, $rofi_launcher"
      ];

      exec-once = [
        "autostart"
      ];
    };
  };
}