_: {
  services.xserver.xkb = {
    layout = "tetra";
    extraLayouts = {
      tetra = {
        description = "tetra's custom layout";
        languages = [ "custom" ];
        symbolsFile = ./tetra/layout;
      };
      csurtok = {
        description = "sitelen pona";
        symbolsFile = ./csurtok/layout;
      };
    };
  };
}
