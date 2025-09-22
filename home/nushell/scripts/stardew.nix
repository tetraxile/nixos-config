with import <nixpkgs> { };
mkShell {
  buildInputs = [
    dotnet-sdk
    mono
    openssl
  ];
  LD_LIBRARY_PATH = lib.makeLibraryPath [
    freetype
    libGL
    pulseaudio
    xorg.libX11
    xorg.libXrandr
    openssl
  ];

  DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = "1";
  shellHook = ''
    ${dotnet-sdk}/bin/dotnet "/home/tetra/games/stardew/game/Stardew Valley.dll"
    exit
  '';
}
