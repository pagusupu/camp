{pkgs, ...}: {
  programs = {
    alejandra.enable = true;
    deadnix.enable = true;
    statix.enable = true;
  };
  settings.formatter."nufmt" = {
    command = "${pkgs.nufmt}/bin/nufmt";
    includes = ["*.nu"];
  };
  projectRootFile = "flake.nix";
}
