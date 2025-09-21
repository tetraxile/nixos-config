{
  pkgs,
  isDesktop,
  ...
}:
let
  stardewScript = pkgs.writeNushellScriptBin "stardew" "nix-shell ${./stardew.nix}";
in
{
  home.packages = [
    pkgs.sshpass
  ]
  ++ (
    if isDesktop then
      [
        stardewScript
      ]
    else
      [ ]
  );

  programs.nushell.extraConfig = ''
    use ${./pass.nu} *
  '';
}
