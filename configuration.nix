{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ] ++ [
    ./modules/dunst.nix
  ];

  boot.loader = {
    # use systemd-boot EFI boot loader
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;

    hosts = {
      "192.168.1.162" = ["switch"];
      "192.168.1.166" = ["printer"];
      "192.168.1.254" = ["router"];
    };
  };

  time.timeZone = "Europe/Dublin";

  environment.pathsToLink = [ "/libexec" ];

  environment.shellAliases = {
    cal = "cal -m";
    feh = "feh --force-aliasing --keep-zoom-vp";
    neofetch = "hyfetch";
    gdb-switch = "gdb-multiarch -ex \"target extended-remote $SWITCH_IP:22225\" -ex \"monitor wait application\"";
    rc = "radix-calc";
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  environment.systemPackages = with pkgs; [
    acpi            # ACPI battery info
    anki-bin        # spaced repetition system app
    brightnessctl   # control screen brightness
    cargo           # rust dependency manager
    clipmenu        # inspect clipboard with dmen
    cmus            # console music player
    dig             # DNS tool
    dunst           # notification daemon
    escrotum        # screenshot tool
    feh             # image viewer
    ffmpeg          # convert video/audio formats
    file            # view info about a file
    firefox         # web browser
    foot            # lightweight terminal
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
    pciutils        # pci cli utils
    pinentry-gtk2   # enter GPG password
    prismlauncher   # minecraft launcher
    qbittorrent-nox # bittorrent client
    ripgrep         # easier-to-use alternative to grep
    rustc           # rust compiler
    steam-run       # run games that have FHS requirements
    unzip           # extract .zip archives
    usbutils        # usb cli utils
    vim             # text editor
    vlc             # media player
    wget            # download web files
    wireguard-tools # view wireguard status
    wirelesstools   # wireless tools
    x265            # decode H.265 video codec
    xclip           # clipboard support for neovim
    xcwd            # get working directory of focused window
    xsecurelock     # lock the screen (with xset s activate)
    xss-lock        # use external screen locker
    
    # python 3.12
    (python312.withPackages(ps: with ps; [ mutagen ]))
  ];

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      noto-fonts-cjk-serif
    ];

    fontconfig.defaultFonts = {
      monospace = [ "JetBrainsMonoNL NF" ];
    };
  };

  services = {
    # X11
    xserver = {
      enable = true;

      displayManager = {
        defaultSession = "none+i3";
        lightdm.enable = true;
        lightdm.background = "#000000";
        autoLogin.enable = true;
        autoLogin.user = "tetra";
      };

      windowManager.i3 = {
        enable = true;
        configFile = /home/tetra/.config/i3/config;
        extraPackages = with pkgs; [
          dmenu
          i3blocks
        ];
      };

      xkb.layout = "us";
      libinput.enable = true;
      libinput.touchpad.naturalScrolling = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 30;
      desktopManager.runXdgAutostartIfNone = true;
    };

    # enable vsync to stop screen tearing
    picom = {
      enable = true;
      vSync = true;
    };

    # audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # systemd-resolved

    mullvad-vpn = {
      enable = true;
      enableExcludeWrapper = false;
    };

    locate = {
      enable = true;
      package = pkgs.mlocate;
      localuser = null;
    };

    clipmenu.enable = true;
    dunst.enable = true;
    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };
    resolved.enable = true;
  };
  
  security = {
    # enable realtime priority for pulseaudio
    rtkit.enable = true;

    sudo = {
      enable = true;
      extraRules = [{
        commands = [
          {
            command = "/run/current-system/sw/bin/wg";
            options = [ "NOPASSWD" ];
          }
        ];
        groups = [ "wheel" ];
      }];
    };
  };

  programs = {
    zsh.enable = true;
    
    git = {
      enable = true;
      config = {
        user = {
          email = "tetraxile@proton.me";
          name = "tetraxile";
          signingkey = "AB1243FD5015BF6A";
        };
        credential.helper = "cache";
        commit.gpgsign = true;
        tag.gpgsign = true;
        url."https://".insteadof = "git://";
        init.defaultBranch = "main";
        http.sslVerify = false;
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gtk2;
      settings = {
        default-cache-ttl = 120;
        max-cache-ttl = 120;
      };
    };
  
    # enable running unpackaged non-nix executables
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # Add any missing dynamic libraries for unpackaged programs
        # here, NOT in environment.systemPackages
      ];
    };
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.tetra = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = [];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "tetra" = import ./home.nix;
    };
  };

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    inputMethod.enabled = "fcitx5";
    inputMethod.fcitx5.addons = with pkgs; [ fcitx5-mozc ];
  };

  # allow building certain packages with unfree licenses
  # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #   "steam-run"
  #   "steam-original-1.0.0.74"
  # ];
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}

