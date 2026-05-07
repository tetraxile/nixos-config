{
  pkgs,
  isDesktop,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      cargo # rust dependency manager
      clang-tools # tools for c/c++
      fastfetch # neofetch replacement
      ffmpeg # convert video/audio formats
      file # view info about a file
      gcc # C/C++ compiler
      gnupg # GNU OpenPGP implementation
      hactool
      hyfetch # pride flags neofetch
      inetutils
      jq # pretty print JSON
      man-pages # linux man pages
      p7zip # extract .7z archives
      pass # password manager
      ripgrep # easier-to-use alternative to grep
      unzip # extract .zip archives
      usbutils # usb cli utils
      wget # download web files
      bottom # system monitor
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
          xkill

          pinentry-gtk2 # enter GPG password
          x265 # decode H.265 video codec
          hplip # HP printer drivers

          dunst # notification daemon

          audacity
          anki # spaced repetition system app
          aseprite
          cmus # console music player
          floorp-bin # web browser
          stable-pkgs.ghidra # disassembler/decompiler
          stable-pkgs.krita
          mpv # media player
          musescore # music notation
          nicotine-plus
          obsidian
          pavucontrol # pulseaudio volume control
          prismlauncher # minecraft launcher
          proton-vpn # VPN client
          puddletag # music tagging
          qbittorrent-nox # bittorrent client
          texstudio # LaTeX editor
          texliveFull # LaTeX distribution
          thunderbird # calendar
          vlc # media player
          vscodium # IDE
          wezterm # terminal
          thunar # file browser & FTP client
          zen-browser # web browser

          # python
          (python314.withPackages (ps: with ps; [ mutagen ]))
        ]
      else
        [ ]
    );
}
