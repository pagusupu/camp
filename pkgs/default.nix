{inputs, ...}: {
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    overlayAttrs = {inherit (config.packages) nix rose-pine-gtk-theme;};
    packages = {
      nix = pkgs.lix;
      rose-pine-gtk-theme = pkgs.callPackage ./rose-pine-gtk-theme.nix {};
    };
  };
  imports = [inputs.flake-parts.flakeModules.easyOverlay];
}
