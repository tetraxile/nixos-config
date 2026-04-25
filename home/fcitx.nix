{
  isDesktop,
  pkgs,
  ...
}:
{
  i18n.inputMethod = {
    enable = isDesktop;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-table-other
      ];
    };
  };
}
