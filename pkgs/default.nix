{inputs, ...}: {
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    overlayAttrs = {inherit (config.packages) rose-pine-gtk-theme;};
    packages.rose-pine-gtk-theme = pkgs.callPackage ./rose-pine-gtk-theme.nix {};
  };
  imports = [inputs.flake-parts.flakeModules.easyOverlay];
}
