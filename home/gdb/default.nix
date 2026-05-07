{
  pkgs,
  isDesktop,
  ...
}:
{
  home = {
    packages =
      with pkgs;
      (
        if isDesktop then
          [
            gdb
          ]
        else
          [ ]
      );

    file.".gdbinit".source = ./gdbinit;
  };
}
