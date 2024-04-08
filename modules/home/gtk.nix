{
  config,
  lib,
  inputs,
  colours,
  ...
}: {
  imports = [inputs.base16.nixosModule];
  options.cute.home = {
    base16 = lib.mkEnableOption "";
    gtk = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.home.base16 {
    console.colors = let
      inherit (colours) dark;
    in [
      "000000"
      dark.love
      dark.foam
      dark.gold
      dark.pine
      dark.iris
      dark.rose
      dark.text
      dark.overlay
      dark.love
      dark.foam
      dark.gold
      dark.pine
      dark.iris
      dark.rose
      dark.text
    ];
  };
}
