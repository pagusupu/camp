{inputs, ...}: {
  perSystem = {pkgs, ...}: rec {
    packages = {
      nix = pkgs.lix;

      alejandra-custom = pkgs.callPackage ./alejandra-custom {};
      gtk-rose-pine = pkgs.callPackage ./gtk-rose-pine {};
      nvim-rose-pine = pkgs.callPackage ./nvim-rose-pine {};
    };
    overlayAttrs = packages;
  };
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];
}
