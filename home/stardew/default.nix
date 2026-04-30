{
  pkgs,
  isDesktop,
  ...
}:
let
  stardewScript = pkgs.writeShellScriptBin "stardew" "nix-shell ${./stardew.nix}";
in
{
  home.packages = (
    if isDesktop then
      [
        stardewScript
      ]
    else
      [ ]
  );

}
