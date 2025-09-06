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
      dunst           # notification daemon
      feh             # image viewer
      ffmpeg          # convert video/audio formats
      file            # view info about a file
      firefox         # web browser
      fusee-nano      # nintendo switch payload injector
      gcc             # C/C++ compiler
      ghidra          # disassembler/decompiler
      hplip           # HP printer drivers
      hyfetch         # pride flags neofetch
      man-pages       # linux man pages
      mpv             # media player
      musescore       # music notation
      nix-index       # nixpkgs database
      p7zip           # extract .7z archives
      pass            # password manager
      pinentry-gtk2   # enter GPG password
      prismlauncher   # minecraft launcher
      qbittorrent-nox # bittorrent client
      ripgrep         # easier-to-use alternative to grep
      rustc           # rust compiler
      unzip           # extract .zip archives
      usbutils        # usb cli utils
      vlc             # media player
      wezterm         # terminal
      wget            # download web files
      wireguard-tools # view wireguard status
      wirelesstools   # wireless tools
      x265            # decode H.265 video codec
      
      # python 3.12
      (python312.withPackages(ps: with ps; [ mutagen ]))
    ];

    file = {
      ".config/i3blocks/config".source = ./home/i3blocks/config;
      ".config/i3blocks/scripts/battery".source = ./home/i3blocks/scripts/battery;
      ".config/i3blocks/scripts/brightness".source = ./home/i3blocks/scripts/brightness;
      ".config/i3blocks/scripts/datetime".source = ./home/i3blocks/scripts/datetime;
      ".config/i3blocks/scripts/volume".source = ./home/i3blocks/scripts/volume;
      ".config/i3blocks/scripts/vpn".source = ./home/i3blocks/scripts/vpn;
      ".config/i3blocks/vars".text = ''
      2
      0
      '';

      ".config/nvim/init.lua".source = ./home/nvim/init.lua;
      ".config/nvim/lazy-lock.json".source = ./home/nvim/lazy-lock.json;

      ".gtkrc-2.0".source = ./home/gtk/settings-2.0.ini;
      ".config/gtk-3.0/settings.ini".source = ./home/gtk/settings-3.0.ini;
    };

    sessionVariables = {
    
    };

    stateVersion = "25.05";
  };

  wayland.windowManager.sway = {
    enable = true;
  };

  services.dunst.enable = true;
  
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gtk2;
    defaultCacheTtl = 120;
    maxCacheTtl = 120;
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
    initExtra = ''
      unsetopt beep

      bindkey "^[[3~" delete-char       # Del = delete character right
      bindkey "^[[1;5C" forward-word    # Ctrl+Right = move one word right
      bindkey "^[[1;5D" backward-word   # Ctrl+Left = move one word left
      bindkey "^[[3;5~" delete-word     # Ctrl+Del = delete one word right
      bindkey "^H" backward-delete-word # Ctrl+Backspace = delete one word left

      zstyle :compinstall filename "$HOME/.zshrc"
      zstyle ':completion:*' rehash true

      export PROMPT="%B%2~%b %# ";
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
