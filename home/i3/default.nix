{
  config,
  pkgs,
  isDesktop,
  specialArgs,
  ...
}: {
  # imports = [./i3blocks];

  home.packages = with pkgs; [
    dmenu
    clipmenu
    scrot
    xclip
    xsecurelock
    xss-lock
  ];

  xsession.windowManager.i3 = {
    enable = true;
    config = let
      mod = "Mod4";
      alt = "Mod1";
      modeSystem = "loc[k], [l]ogout, [s]uspend, [r]eboot, [S]hutdown";
    in {
      modifier = mod;

      fonts = {
        names = ["JetBrainsMono NF"];
        size = 8.0;
      };

      keybindings =
        /*
        lib.mkForce
        */
        {
          # start terminal
          "${mod}+Return" = "exec ${pkgs.wezterm}/bin/wezterm";

          # start clipmenu
          "${mod}+z" = "exec --no-startup-id ${pkgs.clipmenu}/bin/clipmenu";

          # start passmenu
          "${mod}+p" = "exec --no-startup-id ${pkgs.pass}/bin/passmenu";

          # start dmenu
          "${mod}+d" = "exec --no-startup-id SHELL=/bin/sh ${pkgs.dmenu}/bin/dmenu_run";

          # start browser
          "${mod}+q" = "exec ${pkgs.floorp}/bin/floorp";

          # eyedropper
          # zoomer
          # switch input method

          # take screenshot and copy to clipboard
          "${mod}+c" = "exec --no-startup-id scrot -s - | xclip -selection clipboard -target image/png";

          # take screenshot and save to file
          # "${mod}+Alt+c" = "exec escrotum -s '$HOME/Pictures/screenshot-%Y%m%d-%H%M%S.png'";

          # kill focused container
          "${mod}+Shift+q" = "kill";

          # change focus
          "${mod}+Up" = "focus up";
          "${mod}+Down" = "focus down";
          "${mod}+Left" = "focus left";
          "${mod}+Right" = "focus right";

          # move focused container
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Right" = "move right";

          # split horizontally
          "${mod}+h" = "split h";

          # split vertically
          "${mod}+v" = "split v";

          # enter fullscreen for focused container
          "${mod}+f" = "fullscreen toggle";

          # change container layout (stacked, tabbed, toggle split)
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";

          # toggle tiling / floating
          "${mod}+Shift+space" = "floating toggle";

          # change focus between tiling / floating containers
          "${mod}+space" = "focus mode_toggle";

          # focus the parent container
          "${mod}+a" = "focus parent";

          # focus the child container
          "${mod}+g" = "focus child";

          # move current container to the next monitor
          "${mod}+x" = "move workspace to output next";

          # reload the configuration file
          "${mod}+Shift+c" = "reload";

          # restart i3 inplace (preserves layout/session, can be used to upgrade it)
          "${mod}+Shift+r" = "restart";

          # switch to workspace
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";

          # move focused container to workspace
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";

          # use wpctl to adjust volume
          "XF86AudioRaiseVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@   5%+ --limit 1.0 && pkill -RTMIN+2 i3blocks";
          "XF86AudioLowerVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@   5%- --limit 1.0 && pkill -RTMIN+2 i3blocks";
          "XF86AudioMute" = "exec --no-startup-id wpctl set-mute   @DEFAULT_AUDIO_SINK@   toggle          && pkill -RTMIN+2 i3blocks";
          "XF86AudioMicMute" = "exec --no-startup-id wpctl set-mute   @DEFAULT_AUDIO_SOURCE@ toggle          && pkill -RTMIN+2 i3blocks";

          # use brightnessctl to adjust brightness
          "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl s 5%+ && pkill -RTMIN+3 i3blocks";
          "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl s 5%- && pkill -RTMIN+3 i3blocks";

          # change modes
          "${mod}+r" = "mode resize";
          "${mod}+Escape" = "mode \"${modeSystem}\"";
        };
      modes = {
        resize = {
          "Up" = "resize shrink height 1 px";
          "Down" = "resize grow   height 1 px";
          "Left" = "resize shrink width  1 px";
          "Right" = "resize grow   width  1 px";
          "Control+Up" = "resize shrink height 10 px";
          "Control+Down" = "resize grow   height 10 px";
          "Control+Left" = "resize shrink width  10 px";
          "Control+Right" = "resize grow   width  10 px";
          "Escape" = "mode default";
        };
        "${modeSystem}" = {
          "k" = "exec --no-startup-id xset s activate,                      mode default";
          "l" = "exec --no-startup-id i3-msg exit,                          mode default";
          "s" = "exec --no-startup-id xset s activate && systemctl suspend, mode default";
          "r" = "exec --no-startup-id reboot,                               mode default";
          "Shift+s" = "exec --no-startup-id shutdown now,                         mode default";
          "Escape" = "mode default";
        };
      };
      startup = [
        {
          command = "xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock";
          notification = false;
        }
      ];
      bars = [
        {
          fonts = {
            names = ["JetBrainsMono NF"];
            size = 10.0;
          };
          position = "bottom";
          statusCommand = "i3blocks";
        }
      ];
    };
  };
}
