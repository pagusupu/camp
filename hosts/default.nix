{
  lib,
  inputs,
  withSystem,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    filternix = builtins.concatMap (x:
      builtins.filter (lib.hasSuffix ".nix")
      (map toString (lib.filesystem.listFilesRecursive x)));
    specialArgs = {inherit inputs;};
  in {
    aoi = withSystem "x86_64-linux" (_:
      nixosSystem {
        modules = filternix [../lib ../modules ./aoi] ++ [inputs.lix.nixosModules.default];
        inherit specialArgs;
      });
    ena = withSystem "x86_64-linux" (_:
      nixosSystem {
        modules = filternix [../lib ../modules ./ena];
        inherit specialArgs;
      });
    rin = withSystem "x86_64-linux" (_:
      nixosSystem {
        modules = filternix [../lib ../modules ./rin] ++ [inputs.lix.nixosModules.default];
        inherit specialArgs;
      });
  };
}
