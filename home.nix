{ config, pkgs, ... }:

{
  imports = [ ./home/i3.nix ];

  home = {
    username = "tetra";
    homeDirectory = "/home/tetra";

    pointerCursor = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };

    packages = with pkgs; [
      gnome.adwaita-icon-theme
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
    };

    sessionVariables = {
    
    };

    stateVersion = "23.11";
  };
  
  programs.kitty.settings = {
    enable_audio_bell = false;
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
