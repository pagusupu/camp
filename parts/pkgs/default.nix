{inputs, ...}: {
  perSystem = {pkgs, ...}: rec {
    packages = {
      nix = pkgs.lix;
      rose-pine-gtk = pkgs.callPackage ./rose-pine-gtk {};
      rose-pine-nvim = pkgs.callPackage ./rose-pine-nvim {};
    };
    overlayAttrs = packages;
  };
  imports = [inputs.flake-parts.flakeModules.easyOverlay];
}
