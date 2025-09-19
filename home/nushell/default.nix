{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    shellAliases = {
      ghidra = "_JAVA_AWT_WM_NONREPARENTING=1 ${pkgs.ghidra}/lib/ghidra/ghidraRun";
    };
  };
}
