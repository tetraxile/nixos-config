{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.i3blocks
  ];

  wayland.windowManager.sway.config = {
    bars = [
      {
        fonts = {
          names = ["pango:monospace"];
          size = 10.0;
        };
        statusCommand = "nu -c \"SCRIPT_DIR=${./scripts} i3blocks -c ${./config}\"";
      }
    ];
  };
}
