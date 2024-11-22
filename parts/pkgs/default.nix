{inputs, ...}: {
  perSystem = {pkgs, ...}: rec {
    packages = {
      nix = pkgs.lix;
      gtk-rose-pine = pkgs.callPackage ./gtk-rose-pine {};
      nvim-rose-pine = pkgs.callPackage ./nvim-rose-pine {};
    };
    overlayAttrs = packages;
  };
  imports = [inputs.flake-parts.flakeModules.easyOverlay];
}
