{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
  modeSystem = "loc[k], [l]ogout, [s]uspend, [h]ibernate, [r]eboot, [S]hutdown";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      fonts = { names = ["JetBrainsMono NF"]; size = 8.0; };

      keybindings = lib.mkForce {
        # start terminal
        "${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";

        # start terminal in the same directory as the focused container
        "${mod}+Shift+Return" = "exec ${pkgs.kitty}/bin/kitty $(${pkgs.xcwd}/bin/xcwd)";

        # start clipmenu
        "${mod}+z" = "exec --no-startup-id ${pkgs.clipmenu}/bin/clipmenu";

        # start passmenu
        "${mod}+p" = "exec --no-startup-id ${pkgs.pass}/bin/passmenu";

        # start dmenu
        "${mod}+d" = "exec --no-startup-id ${pkgs.dmenu}/bin/dmenu_run";

        # start browser
        "${mod}+q" = "exec ${pkgs.firefox}/bin/firefox";

        # take screenshot and copy to clipboard
        "${mod}+c" = "exec escrotum -sC";
        
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

        "${mod}+r" = "mode resize";
      };
      modes = {
        resize = {
          "Up"    = "resize shrink height 1 px";
          "Down"  = "resize grow   height 1 px";
          "Left"  = "resize shrink width  1 px";
          "Right" = "resize grow   width  1 px";
          "Control+Up"    = "resize shrink height 10 px";
          "Control+Down"  = "resize grow   height 10 px";
          "Control+Left"  = "resize shrink width  10 px";
          "Control+Right" = "resize grow   width  10 px";
          "Escape" = "mode default";
        };
      };
      bars = [{
        fonts = { names = [ "JetBrainsMono NF" ]; size = 10.0; };
        position = "bottom";
        statusCommand = "SCRIPT_DIR=~/.config/i3blocks/scripts i3blocks";
      }];
    };
    extraConfig = ''
# use pactl to adjust volume in PulseAudio
set $refresh_volume pkill -RTMIN+2 i3blocks
bindsym XF86AudioRaiseVolume exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@   5%+ --limit 1.0 && $refresh_volume
bindsym XF86AudioLowerVolume exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@   5%- --limit 1.0 && $refresh_volume
bindsym XF86AudioMute        exec --no-startup-id wpctl set-mute   @DEFAULT_AUDIO_SINK@   toggle          && $refresh_volume
bindsym XF86AudioMicMute     exec --no-startup-id wpctl set-mute   @DEFAULT_AUDIO_SOURCE@ toggle          && $refresh_volume

# use brightnessctl to adjust brightness
set $refresh_brightness pkill -RTMIN+3 i3blocks
bindsym XF86MonBrightnessUp   exec --no-startup-id brightnessctl s 5%+ && $refresh_brightness
bindsym XF86MonBrightnessDown exec --no-startup-id brightnessctl s 5%- && $refresh_brightness

# take screenshot and save file
# bindsym ${mod}+Alt+c exec escrotum -s '$HOME/Pictures/screenshot-%Y%m%d-%H%M%S.png'

# enable float for some windows
for_window [class="^Pavucontrol$"] floating enable

set $mode_system nixtest, loc[k], [l]ogout, [s]uspend, [h]ibernate, [r]eboot, [S]hutdown
bindsym ${mod}+Escape mode "$mode_system"
set $i3lock xset s activate
mode "$mode_system" {
	bindsym k exec --no-startup-id           $i3lock,              mode "default"
	bindsym l exec --no-startup-id           i3-msg exit,          mode "default"
	bindsym s exec --no-startup-id $i3lock && systemctl suspend,   mode "default"
	bindsym h exec --no-startup-id $i3lock && systemctl hibernate, mode "default"
	bindsym r exec --no-startup-id           reboot,               mode "default"
	bindsym Shift+s exec --no-startup-id     shutdown now,         mode "default"

	# back to normal: Enter or Escape
	bindsym Return mode "default"
	bindsym Escape mode "default"
}


# startup programs + settings
exec --no-startup-id xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock
    '';
  };
}
