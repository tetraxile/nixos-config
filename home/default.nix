{
  config,
  pkgs,
  isDesktop,
  specialArgs,
  inputs,
  ...
}:
{
  imports = [
    ./packages.nix
    ./i3
    ./nushell
    ./xmodmap.nix
    ./git.nix
    ./gtk.nix
    ./fcitx.nix
    ./zsh.nix
    ./stardew
    ./gdb
    ./nixcord.nix
    inputs.nixcord.homeModules.nixcord
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

    file = {
      ".config/nvim/init.lua".source = ./nvim/init.lua;
      ".config/nvim/lazy-lock.json".source = ./nvim/lazy-lock.json;
    };

    sessionVariables = {
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
  };

  programs.wezterm = {
    enable = isDesktop;
    extraConfig = builtins.readFile ./wezterm/wezterm.lua;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
