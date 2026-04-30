{
  config,
  pkgs,
  isDesktop,
  specialArgs,
  ...
}:
{
  imports = [ ./i3blocks ];

  home.packages = with pkgs; [
    dmenu
    clipmenu
    escrotum
    xclip
    xsecurelock
    xss-lock
  ];

  xsession.windowManager.i3 = {
    enable = true;
    config =
      let
        meta = "Mod4";
        alt = "Mod1";
        mod = "Mod3";
        modeSystem = "loc[k], [l]ogout, [s]uspend, [r]eboot, [S]hutdown";
      in
      {
        modifier = meta;

        fonts = {
          names = [ "monospace" ];
          size = 8.0;
        };

        keybindings =
          # lib.mkForce
          {
            # start terminal
            "${meta}+Return" = "exec ${pkgs.wezterm}/bin/wezterm";

            # start clipmenu
            "${meta}+z" = "exec --no-startup-id ${pkgs.clipmenu}/bin/clipmenu";

            # start passmenu
            "${meta}+p" = "exec --no-startup-id ${pkgs.pass}/bin/passmenu";

            # start dmenu
            "${meta}+d" = "exec --no-startup-id ${./dmenu_run.nu}";

            # start browser
            "${meta}+q" = "exec ${pkgs.floorp-bin}/bin/floorp";

            # eyedropper
            # zoomer

            # switch input method
            "${mod}+1" = "exec fcitx5-remote -s keyboard-tetra";
            "${mod}+2" = "exec fcitx5-remote -s mozc";

            # take screenshot and copy to clipboard
            "${meta}+c" = "exec --no-startup-id escrotum -sC";

            # take screenshot and save to file
            # "${meta}+Alt+c" = "exec escrotum -s '$HOME/Pictures/screenshot-%Y%m%d-%H%M%S.png'";

            # kill focused container
            "${meta}+Shift+q" = "kill";

            # change focus
            "${meta}+Up" = "focus up";
            "${meta}+Down" = "focus down";
            "${meta}+Left" = "focus left";
            "${meta}+Right" = "focus right";

            # move focused container
            "${meta}+Shift+Up" = "move up";
            "${meta}+Shift+Down" = "move down";
            "${meta}+Shift+Left" = "move left";
            "${meta}+Shift+Right" = "move right";

            # split horizontally
            "${meta}+h" = "split h";

            # split vertically
            "${meta}+v" = "split v";

            # enter fullscreen for focused container
            "${meta}+f" = "fullscreen toggle";

            # change container layout (stacked, tabbed, toggle split)
            "${meta}+s" = "layout stacking";
            "${meta}+w" = "layout tabbed";
            "${meta}+e" = "layout toggle split";

            # toggle tiling / floating
            "${meta}+Shift+space" = "floating toggle";

            # change focus between tiling / floating containers
            "${meta}+space" = "focus mode_toggle";

            # focus the parent container
            "${meta}+a" = "focus parent";

            # focus the child container
            "${meta}+g" = "focus child";

            # move current container to the next monitor
            "${meta}+x" = "move workspace to output next";

            # reload the configuration file
            "${meta}+Shift+c" = "reload";

            # restart i3 inplace (preserves layout/session, can be used to upgrade it)
            "${meta}+Shift+r" = "restart";

            # switch to workspace
            "${meta}+1" = "workspace number 1";
            "${meta}+2" = "workspace number 2";
            "${meta}+3" = "workspace number 3";
            "${meta}+4" = "workspace number 4";
            "${meta}+5" = "workspace number 5";
            "${meta}+6" = "workspace number 6";
            "${meta}+7" = "workspace number 7";
            "${meta}+8" = "workspace number 8";
            "${meta}+9" = "workspace number 9";

            # move focused container to workspace
            "${meta}+Shift+1" = "move container to workspace number 1";
            "${meta}+Shift+2" = "move container to workspace number 2";
            "${meta}+Shift+3" = "move container to workspace number 3";
            "${meta}+Shift+4" = "move container to workspace number 4";
            "${meta}+Shift+5" = "move container to workspace number 5";
            "${meta}+Shift+6" = "move container to workspace number 6";
            "${meta}+Shift+7" = "move container to workspace number 7";
            "${meta}+Shift+8" = "move container to workspace number 8";
            "${meta}+Shift+9" = "move container to workspace number 9";

            # use wpctl to adjust volume
            "XF86AudioRaiseVolume" =
              "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@   5%+ --limit 1.0 && pkill -RTMIN+2 i3blocks";
            "XF86AudioLowerVolume" =
              "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@   5%- --limit 1.0 && pkill -RTMIN+2 i3blocks";
            "XF86AudioMute" =
              "exec --no-startup-id wpctl set-mute   @DEFAULT_AUDIO_SINK@   toggle          && pkill -RTMIN+2 i3blocks";
            "XF86AudioMicMute" =
              "exec --no-startup-id wpctl set-mute   @DEFAULT_AUDIO_SOURCE@ toggle          && pkill -RTMIN+2 i3blocks";

            # use brightnessctl to adjust brightness
            "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl s 5%+ && pkill -RTMIN+3 i3blocks";
            "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl s 5%- && pkill -RTMIN+3 i3blocks";

            # change modes
            "${meta}+r" = "mode resize";
            "${meta}+Escape" = "mode \"${modeSystem}\"";
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
          {
            command = "xmodmap ~/.Xmodmap";
            notification = false;
          }
        ];
      };
  };
}
