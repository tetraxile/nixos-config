{
  config,
  pkgs,
  ...
}:
{
  imports = [ ./module.nix ];

  home.packages = [
    pkgs.i3blocks
  ];

  xsession.windowManager.i3.config = {
    bars = [
      {
        fonts = {
          names = [ "JetBrainsMono NF" ];
          size = 10.0;
        };
        position = "bottom";
        statusCommand = "${pkgs.i3blocks}/bin/i3blocks";
      }
    ];
  };

  i3blocks = {
    global = {
      separator = true;
      separator_block_width = 15;
      markup = "pango";
    };

    blocks = [
      {
        name = "vpn";
        interval = 5;
        command = toString ./scripts/vpn;
      }

      {
        name = "network";
        interval = 5;
        command = toString ./scripts/network;
        json = true;
      }

      {
        name = "volume";
        interval = "once";
        signal = 2;
        command = toString ./scripts/volume;
      }

      {
        name = "brightness";
        interval = "once";
        signal = 3;
        command = toString ./scripts/brightness;
      }

      {
        name = "battery";
        signal = 2;
        command = toString ./scripts/battery;
      }

      {
        name = "datetime";
        interval = 1;
        json = true;
        command = toString ./scripts/datetime;
      }
    ];
  };
}
