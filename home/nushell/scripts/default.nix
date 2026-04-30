{
  pkgs,
  isDesktop,
  ...
}:
{
  home.packages = [ pkgs.sshpass ];

  programs.nushell.extraConfig = ''
    use ${./pass.nu} *
  '';
}
