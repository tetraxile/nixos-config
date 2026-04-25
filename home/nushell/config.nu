$env.config.show_banner = false
$env.config.history = {
  max_size: 100_000
  sync_on_enter: true
  file_format: "sqlite"
  isolation: true
};

$env.config.filesize.unit = "binary";

alias nsu = nix-shell --command nu

$env.EDITOR = "nvim"

use std "path add"
$env.PATH = ($env.PATH | split row (char esep));
path add ($env.HOME | path join ".local" "bin");
path add ($env.HOME | path join .cargo bin)
$env.PATH = ($env.PATH | uniq);

