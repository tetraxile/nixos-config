{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    xmodmap
  ];

  home.file.".Xmodmap".text = ''
    ! remap caps lock to be an alternative modifier key (Mod3)
    clear lock
    keycode 66 = ISO_Level5_Shift
  '';
}
