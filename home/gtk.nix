{
  isDesktop,
  ...
}:
{
  gtk = {
    enable = isDesktop;

    gtk2.extraConfig = ''
      gtk-cursor-theme-name="Adwaita"
      gtk-cursor-theme-size=24
      gtk-error-bell=0
    '';

    gtk3.extraConfig = {
      gtk-cursor-theme-name = "Adwaita";
      gtk-cursor-theme-size = 24;
      gtk-error-bell = 0;
    };

    gtk4.theme = null;
  };
}
