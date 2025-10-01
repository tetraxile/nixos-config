{
  config,
  pkgs,
  isDesktop,
  specialArgs,
  ...
}:
{
  imports = [
    ./i3
    ./nushell
  ];

  home = {
    stateVersion = "25.05";

    username = "tetra";
    homeDirectory = "/home/tetra";

    pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 32;
    };

    packages =
      with pkgs;
      [
        cargo # rust dependency manager
        clang-tools # tools for c/c++
        ffmpeg # convert video/audio formats
        file # view info about a file
        gcc # C/C++ compiler
        gnupg # GNU OpenPGP implementation
        hyfetch # pride flags neofetch
        man-pages # linux man pages
        nix-index # nixpkgs database
        p7zip # extract .7z archives
        pass # password manager
        ripgrep # easier-to-use alternative to grep
        rustc # rust compiler
        unzip # extract .zip archives
        usbutils # usb cli utils
        wget # download web files
        htop
      ]
      ++ (
        if isDesktop then
          [
            acpi # ACPI battery info
            brightnessctl # control screen brightness
            fusee-nano # nintendo switch payload injector
            nixfmt-tree # nix formatter
            steam-run
            wireguard-tools # view wireguard status
            wirelesstools # wireless tools
            xorg.xkill

            pinentry-gtk2 # enter GPG password
            x265 # decode H.265 video codec
            hplip # HP printer drivers

            dunst # notification daemon

            anki # spaced repetition system app
            cmus # console music player
            ghidra # disassembler/decompiler
            mpv # media player
            musescore # music notation
            nicotine-plus
            obsidian
            pavucontrol # pulseaudio volume control
            prismlauncher # minecraft launcher
            puddletag # music tagging
            qbittorrent-nox # bittorrent client
            thunderbird # calendar
            vlc # media player
            vscodium # IDE
            wezterm # terminal
            xfce.thunar # file browser & FTP client
            zen-browser # web browser

            # python 3.12
            (python312.withPackages (ps: with ps; [ mutagen ]))
          ]
        else
          [ ]
      );

    file = {
      ".config/nvim/init.lua".source = ./nvim/init.lua;
      ".config/nvim/lazy-lock.json".source = ./nvim/lazy-lock.json;
    };

    sessionVariables = {
    };
  };

  gtk = {
    enable = isDesktop;

    gtk2.extraConfig = ''
      gtk-cursor-theme-name="Adwaita"
      gtk-cursor-theme-size=24
      gtk-error-bell=0
    '';

    gtk3.extraConfig = {
      gtk-cursor-theme-name = "Adwaita";
      gtk-cursor-theme-size = 24;
      gtk-error-bell = 0;
    };
  };

  i18n.inputMethod = {
    enable = isDesktop;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-mozc
      ];
    };
  };

  services = {
    dunst.enable = isDesktop;

    gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-gtk2;
      defaultCacheTtl = 120;
      maxCacheTtl = 120;
    };

    protonmail-bridge.enable = isDesktop;
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

  programs.wezterm = {
    enable = isDesktop;
    extraConfig = builtins.readFile ./wezterm/wezterm.lua;
  };

  programs.vesktop = {
    enable = isDesktop;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
