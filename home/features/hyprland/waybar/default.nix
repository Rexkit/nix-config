{pkgs, lib, ...}: {
  programs.waybar = {
    enable = true;
    style = lib.mkForce ./styles.css;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        exclusive = true;
        passthrough = false;
        spacing = 6;
        margin = "0";
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        fixed-center = true;
        ipc = true;

        modules-left = [ "cpu" "memory" "disk" "idle_inhibitor" ];
        modules-center = [ "hyprland/workspaces" "tray" ];
        modules-right = [ "pulseaudio" "backlight" "network" "battery" "clock" ];

        "backlight" = {
          interval = 2;
          align = 0;
          rotate = 0;
          format = "{icon} {percent}%";
          format-icons = [ "" "" "" "" ];
          on-click = "";
          on-click-middle = "";
          on-click-right = "";
          on-update = "";
          on-scroll-up = "light -A 5%";
          on-scroll-down = "light -U 5%";
          smooth-scrolling-threshold = 1;
        };

        "battery" = {
          interval = 60;
          align = 0;
          rotate = 0;
          full-at = 100;
          design-capacity = false;
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-full = "{icon} Full";
          format-alt = "{icon} {time}";
          format-icons = [ "" "" "" "" "" ];
          format-time = "{H}h {M}min";
          tooltip = true;
        };

        "bluetooth" = {
          "format" = " {status}";
          "format-on" = " {status}";
          "format-off" = " {status}";
          "format-disabled" = " {status}";
          "format-connected" = " {device_alias}";
          "format-connected-battery" = " {device_alias}, {device_battery_percentage}%";
          "tooltip" = true;
          "tooltip-format" = "{controller_alias}\t{controller_address}";
          "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          "on-click" = "~/.config/rofi/scripts/rofi_bluetooth";
          "on-click-right" = "blueman-manager";
        };

        "clock" = {
          "interval" = 60;
          "align" = 0;
          "rotate" = 0;
          "tooltip-format" = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
          "format" = " {:%I:%M %p}";
          "format-alt" = " { =%a %b %d, %G}";
        };

        "custom/power" = {
          "format" = "襤";
          "tooltip" = false;
          "on-click" = "$HOME/.config/rofi/scripts/rofi_powermenu";
        };

        "cpu" = {
          "interval" = 5;
          "format" = " LOAD: {usage:2}%";
        };

        "disk" = {
          "interval" = 30;
          "format" = " FREE: {free}";
        };

        "memory" = {
          "interval" = 10;
          "format" = " USED: {used:3.1f}G";
        };

        "network" = {
          "interval" = 5;
          "format-wifi" = " {essid}";
          "format-ethernet" = " {ipaddr}/{cidr}";
          "format-linked" = " {ifname} (No IP)";
          "format-disconnected" = "睊 Disconnected";
          "format-disabled" = "睊 Disabled";
          "format-alt" = " {bandwidthUpBits} |  {bandwidthDownBits}";
          "tooltip-format" = " {ifname} via {gwaddr}";
        };

        "pulseaudio" = {
          "format" = "{icon} {volume}%";
          "format-muted" = " Mute";
          "format-bluetooth" = " {volume}% {format_source}";
          "format-bluetooth-muted" = " Mute";
          "format-source" = " {volume}%";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ "" "" "" ];
          };
          "scroll-step" = 5.0;
          "on-click" = "pulsemixer --toggle-mute";
          "on-click-right" = "pulsemixer --toggle-mute";
          "smooth-scrolling-threshold" = 1;
        };

        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
          "timeout" = 30;
        };

        "hyprland/workspaces" = {
          "format" = "{icon}";
          "sort-by-number" = true;
          "active-only" = false;
          "format-icons" = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "漣";
              "7" = "";
              "8" = "";
              "9" = "";
              "10" = "ﳴ";
              "urgent" = "";
              "focused" = "";
              "default" = "";
          };
          "persistent-workspaces" = {
            "*" = 8;
          };
          "on-click" = "activate";
        };

        "tray" = {
          "icon-size" = 16;
          "spacing" = 10;
        };
      };
    };
  };
}