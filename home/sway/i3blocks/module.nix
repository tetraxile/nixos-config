{ lib }:
with lib;
with lib.types;
{
  options.i3blocks = let
    keys = submodule {
      interval = mkOption {
        default = "once";
        type = (oneOf [ int (strMatching "^once$") ];
      };

      signal = mkOption {
        type = int;
      };

      label = mkOption {
        type = str;
      };

      separator = mkOption {
        type = bool;
      };
    };
  in {
    global = mkOption { type = submodule } // keys;
    block = mkOption { type = submodule } // keys;
  };
}
