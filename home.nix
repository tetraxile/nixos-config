{ config, pkgs, ... }:

{
  imports = [ ./home/i3.nix ];

  home = {
    username = "tetra";
    homeDirectory = "/home/tetra";

    pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 32;
    };

    packages = with pkgs; [
      acpi            # ACPI battery info
      anki-bin        # spaced repetition system app
      brightnessctl   # control screen brightness
      cargo           # rust dependency manager
      clang-tools     # tools for c/c++
      cmus            # console music player
      dig             # DNS tool
      dmenu-wayland   # wayland launcher menu
      dunst           # notification daemon
      feh             # image viewer
      ffmpeg          # convert video/audio formats
      file            # view info about a file
      floorp          # web browser
      fusee-nano      # nintendo switch payload injector
      gcc             # C/C++ compiler
      ghidra          # disassembler/decompiler
      gnupg           # GNU OpenPGP implementation
      grim            # wayland screenshot
      hplip           # HP printer drivers
      hyfetch         # pride flags neofetch
      hyprpicker      # wayland color picker
      man-pages       # linux man pages
      mpv             # media player
      musescore       # music notation
      nix-index       # nixpkgs database
      p7zip           # extract .7z archives
      pass            # password manager
      pavucontrol     # pulseaudio volume control
      pinentry-gtk2   # enter GPG password
      prismlauncher   # minecraft launcher
      qbittorrent-nox # bittorrent client
      ripgrep         # easier-to-use alternative to grep
      rustc           # rust compiler
      slurp           # select wayland region
      unzip           # extract .zip archives
      usbutils        # usb cli utils
      vlc             # media player
      waybar          # wayland bar
      wezterm         # terminal
      wget            # download web files
      wireguard-tools # view wireguard status
      wirelesstools   # wireless tools
      wl-clipboard    # wayland clipboard utilities
      x265            # decode H.265 video codec
      
      # python 3.12
      (python312.withPackages(ps: with ps; [ mutagen ]))
    ];

    file = {
      ".config/nvim/init.lua".source = ./home/nvim/init.lua;
      ".config/nvim/lazy-lock.json".source = ./home/nvim/lazy-lock.json;

      ".gtkrc-2.0".source = ./home/gtk/settings-2.0.ini;
      ".config/gtk-3.0/settings.ini".source = ./home/gtk/settings-3.0.ini;
    };

    sessionVariables = {
    
    };

    stateVersion = "25.05";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-mozc
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      monitor = eDP-1,preferred,auto,1

      $mod = SUPER

      $terminal = wezterm
      $menu = dmenu-wl_run
      $browser = floorp

      bind = $mod, RETURN, exec, $terminal
      bind = $mod, q, exec, $browser
      bind = $mod, d, exec, $menu
      bind = $mod, c, exec, slurp | grim -g - - | wl-copy

      bindle = , XF86MonBrightnessUp, exec, brightnessctl s 5%+
      bindle = , XF86MonBrightnessDown, exec, brightnessctl s 5%-
      bindle = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bindle = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindl = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

      bind = $mod SHIFT, q, killactive,
      bind = $mod SHIFT, space, togglefloating,
      bind = $mod, Up, movefocus, u
      bind = $mod, Down, movefocus, d
      bind = $mod, Left, movefocus, l
      bind = $mod, Right, movefocus, r
      bind = $mod SHIFT, Up, movewindow, u
      bind = $mod SHIFT, Down, movewindow, d
      bind = $mod SHIFT, Left, movewindow, l
      bind = $mod SHIFT, Right, movewindow, r
      bind = $mod, 1, workspace, 1
      bind = $mod, 2, workspace, 2
      bind = $mod, 3, workspace, 3
      bind = $mod, 4, workspace, 4
      bind = $mod, 5, workspace, 5
      bind = $mod, 6, workspace, 6
      bind = $mod, 7, workspace, 7
      bind = $mod, 8, workspace, 8
      bind = $mod, 9, workspace, 9
      bind = $mod SHIFT, 1, focusworkspaceoncurrentmonitor, 1
      bind = $mod SHIFT, 2, focusworkspaceoncurrentmonitor, 2
      bind = $mod SHIFT, 3, focusworkspaceoncurrentmonitor, 3
      bind = $mod SHIFT, 4, focusworkspaceoncurrentmonitor, 4
      bind = $mod SHIFT, 5, focusworkspaceoncurrentmonitor, 5
      bind = $mod SHIFT, 6, focusworkspaceoncurrentmonitor, 6
      bind = $mod SHIFT, 7, focusworkspaceoncurrentmonitor, 7
      bind = $mod SHIFT, 8, focusworkspaceoncurrentmonitor, 8
      bind = $mod SHIFT, 9, focusworkspaceoncurrentmonitor, 9

      input {
        kb_layout = ie
        repeat_delay = 200
        repeat_rate = 30

        touchpad {
          natural_scroll = yes
          scroll_factor = 0.2
        }
      }

      animations {
        enabled = false
      }

      misc {
        disable_hyprland_logo = true
      }

      exec-once = dunst
      exec = pkill waybar && sleep 0.5 && waybar
    '';
  };

  services = {
    dunst.enable = true;
  
    gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-gtk2;
      defaultCacheTtl = 120;
      maxCacheTtl = 120;
    };
  };

  programs.git = {
    enable = true;
    userEmail = "tetraxile@proton.me";
    userName = "tetraxile";
    signing.key = "AB1243FD5015BF6A";

    extraConfig = {
      credential.helper = "cache";
      commit.gpgsign = true;
      tag.gpgsign = true;
      url."https://".insteadof = "git://";
      init.defaultBranch = "main";
      http.sslVerify = false;
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };

  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    initContent = ''
      unsetopt beep

      bindkey "^[[3~" delete-char       # Del = delete character right
      bindkey "^[[1;5C" forward-word    # Ctrl+Right = move one word right
      bindkey "^[[1;5D" backward-word   # Ctrl+Left = move one word left
      bindkey "^[[3;5~" delete-word     # Ctrl+Del = delete one word right
      bindkey "^H" backward-delete-word # Ctrl+Backspace = delete one word left

      zstyle :compinstall filename "$HOME/.zshrc"
      zstyle ':completion:*' rehash true

      if [[ -z "$SSH_CLIENT" ]]; then
        export PROMPT="%B%2~%b %(?..[%F{red}%?%f] )%# ";
      else
        export PROMPT="%B%n@%M:%2~%b %(?..[%F{red}%?%f] )%# ";
      fi

    '';
  };

  programs.vesktop = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "bottom";
        height = 0;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "battery" "network" "pulseaudio" ];

        "battery" = {
          format = "bat {capacity}%";
          interval = 5;
          states = {
            warning = 30;
            critical = 10;
          };
          tooltip = false;
        };

        "pulseaudio" = {
          disable-scroll = true;
          on-click = "pavucontrol";
          tooltip = false;
        };
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
