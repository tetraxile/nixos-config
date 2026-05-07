_: {
  programs = {
    zsh = {
      enable = true;
      history.size = 100000;
      enableCompletion = true;
      autosuggestion.enable = true;

      shellAliases = {
        ls = "ls --color=auto";
        cal = "cal -m";
        feh = "feh --force-aliasing --keep-zoom-vp";
        neofetch = "hyfetch";
        watch-sync = "watch -d grep -e Dirty: -e Writeback: /proc/meminfo";
        nsu = "nix-shell --command zsh";
      };

      initContent = ''
        export PATH="''${HOME}/.local/bin:''${HOME}/.cargo/bin:''${PATH}"

        bindkey "^[[3~" delete-char       # Del = delete character right
        bindkey "^[[1;5C" forward-word    # Ctrl+Right = move one word right
        bindkey "^[[1;5D" backward-word   # Ctrl+Left = move one word left
        bindkey "^[[3;5~" delete-word     # Ctrl+Del = delete one word right
        bindkey "^H" backward-delete-word # Ctrl+Backspace = delete one word left

        source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
      '';
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      presets = [ "plain-text-symbols" ];
    };
  };
}
