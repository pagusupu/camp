{inputs, ...}: {
  perSystem = {pkgs, ...}: rec {
    packages = {
      alejandra-custom = pkgs.callPackage ./alejandra-custom {};
      gtk-rose-pine = pkgs.callPackage ./gtk-rose-pine {};
      hypr-dynamic-cursors = pkgs.callPackage ./hypr-dynamic-cursors {};
      nvim-rose-pine = pkgs.callPackage ./nvim-rose-pine {};

      nix = pkgs.lix;
    };
    overlayAttrs = packages;
  };
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];
}
