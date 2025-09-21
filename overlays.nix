{
  pkgs,
  isDesktop,
  inputs,
  ...
}:
{
  nixpkgs.overlays = [
    (final: _prev: {
      writeNushellScript =
        name: contents:
        final.writeTextFile {
          inherit name;
          executable = true;
          checkPhase = ''
            ${final.nushell}/bin/nu -c "open $target | nu-check -d"
          '';
          text = ''
            #!${final.nushell}/bin/nu
            ${contents}
          '';
        };
      writeNushellScriptBin =
        name: contents:
        final.writeTextFile {
          inherit name;
          executable = true;
          destination = "/bin/${name}";
          checkPhase = ''
            ${final.nushell}/bin/nu -c "open $target | nu-check -d"
          '';
          text = ''
            #!${final.nushell}/bin/nu
            ${contents}
          '';
        };
    })

    (
      final: prev: with inputs; {
        inherit inputs;
        zen-browser = zen-browser.packages.${final.system}.default;
      }
    )
  ];
}
