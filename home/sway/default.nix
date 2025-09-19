{
  config,
  isDesktop,
  specialArgs,
  ...
}: {
  imports = [./i3blocks];

  wayland.windowManager.sway = {
    enable = isDesktop;
    wrapperFeatures.gtk = true;
    xwayland = true;
    config = {
      input = {
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";
          accel_profile = "flat";
          scroll_factor = "0.2";
          pointer_accel = "0.5";
        };
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "0";
        };
        "type:keyboard" = {
          repeat_delay = "200";
          repeat_rate = "30";
        };
      };

      output =
        if specialArgs.hostName == "dovecote"
        then {
          DP-3 = {
            pos = "0 0";
            res = "1920x1080";
          };
          HDMI-A-1 = {
            pos = "1920 0";
            res = "1920x1080";
          };
        }
        else if specialArgs.hostName == "catbox"
        then {
          eDP-1 = {
            pos = "0 0";
            res = "1920x1080";
          };
          HDMI-A-0 = {
            pos = "1920 0";
            res = "1920x1080";
          };
        }
        else {};

      keybindings = let
        mod = "Mod4";
        alt = "Mod1";
      in {
        "${mod}+Return" = "exec wezterm";
        "${mod}+q" = "exec floorp";
        "${mod}+c" = "exec slurp | grim -g - - | wl-copy";
        "${mod}+d" = "exec wmenu-run";

        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        "XF86MonBrightnessUp" = "exec brightnessctl s 5%+";
        "XF86MonBrightnessDown" = "exec brightnessctl s 5%-";

        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";

        "${mod}+x" = "move workspace to output next";

        "${mod}+U" = "focus up";
        "${mod}+Down" = "focus down";
        "${mod}+Left" = "focus left";
        "${mod}+Right" = "focus right";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Right" = "move right";

        "${mod}+a" = "focus parent";
        "${mod}+g" = "focus child";

        "${mod}+Shift+q" = "kill";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+f" = "fullscreen toggle";

        "${mod}+e" = "layout toggle split";
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+v" = "split v";
        "${mod}+h" = "split h";

        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";
      };
    };
  };
}
