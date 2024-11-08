{inputs, ...}: {
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    packages = {
      nix = pkgs.lix;
      rose-pine-gtk-theme = pkgs.callPackage ./rose-pine-gtk-theme.nix {};
    };
    overlayAttrs = {inherit (config.packages) nix rose-pine-gtk-theme;};
  };
  imports = [inputs.flake-parts.flakeModules.easyOverlay];
}
