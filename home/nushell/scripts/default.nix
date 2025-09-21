{
  pkgs,
  isDesktop,
  ...
}:
let
  stardewScript = pkgs.writeNushellScriptBin "stardew" "nix-shell ${./stardew.nix}";
in
{
  home.packages =
    if isDesktop then
      [
        stardewScript
      ]
    else
      [ ];
}
