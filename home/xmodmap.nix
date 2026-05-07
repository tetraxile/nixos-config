{
  pkgs,
  isDesktop,
  ...
}:
{
  home.packages =
    with pkgs;
    (
      if isDesktop then
        [
          xmodmap
        ]
      else
        [ ]
    );

  home.file.".Xmodmap".text = ''
    ! remap caps lock to be an alternative modifier key (Mod3)
    clear lock
    keycode 66 = ISO_Level5_Shift
  '';
}
