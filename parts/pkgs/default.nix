{inputs, ...}: {
  perSystem = {pkgs, ...}: rec {
    packages = {
      nix = pkgs.lix;
      rose-pine-gtk-theme = pkgs.callPackage ./rose-pine-gtk-theme.nix {};
    };
    overlayAttrs = packages;
  };
  imports = [inputs.flake-parts.flakeModules.easyOverlay];
}
