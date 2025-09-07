{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ./modules/dunst.nix
  ];

  boot.loader = {
    # use systemd-boot EFI boot loader
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "catbox";
    networkmanager.enable = true;

    hosts = {
      "192.168.1.1" = ["router"];
      "192.168.1.166" = ["printer"];
      "192.168.1.210" = ["switch"];
      "192.168.1.214" = ["dovecote"];
      "192.168.1.215" = ["catbox"];
      "192.168.1.216" = ["switch"];
    };
  };

  time.timeZone = "Europe/Dublin";

  console.keyMap = "ie";

  i18n = {
    defaultLocale = "nl_NL.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "nl_NL.UTF-8";
      LC_IDENTIFICATION = "nl_NL.UTF-8";
      LC_MEASUREMENT = "nl_NL.UTF-8";
      LC_MONETARY = "nl_NL.UTF-8";
      LC_NAME = "nl_NL.UTF-8";
      LC_NUMERIC = "nl_NL.UTF-8";
      LC_PAPER = "nl_NL.UTF-8";
      LC_TELEPHONE = "nl_NL.UTF-8";
      LC_TIME = "nl_NL.UTF-8";
    };
  };

  environment.shellAliases = {
    ls = "ls --color=auto";
    cal = "cal -m";
    feh = "feh --force-aliasing --keep-zoom-vp";
    neofetch = "hyfetch";
  };

  environment.variables = { };

  environment.systemPackages = with pkgs; [ ];

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-serif
    ];

    fontconfig.defaultFonts = {
      monospace = [ "JetBrainsMonoNL NF" ];
    };
  };

  services = {
    # audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
      };
    };

    locate = {
      enable = true;
      package = pkgs.mlocate;
    };

    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = "greeter";
        };
      };
    };
  };
  
  security = {
    # enable realtime priority for pulseaudio
    rtkit.enable = true;

    sudo.enable = true;
  };

  programs = {
    zsh.enable = true;

    vim.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.tetra = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = [];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOmGxomnzFUz6CMy9NyghrhN1vQ0oeFw2bBdJEd6M9uH tetraxile@proton.me" ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "tetra" = import ./home.nix;
    };
  };

  # allow building certain packages with unfree licenses
  # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #   "steam-run"
  #   "steam-original-1.0.0.74"
  # ];
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}

