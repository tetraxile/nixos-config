{
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  name = "klee-one-font";
  dontConfigure = true;
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp -R ${./KleeOne-Regular.ttf} $out/share/fonts/truetype/
    cp -R ${./KleeOne-SemiBold.ttf} $out/share/fonts/truetype/
  '';
  meta = {
    description = "A nice Japanese handwritten font.";
  };
}
