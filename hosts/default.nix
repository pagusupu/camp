{
  inputs,
  withSystem,
  ...
}: let
  inherit (inputs.nixpkgs.lib) genAttrs nixosSystem hasSuffix filesystem mkMerge;
  genHosts = hosts:
    genAttrs hosts (
      name:
        nixosSystem {
          modules = builtins.concatMap (x:
            builtins.filter (hasSuffix ".nix")
            (map toString (filesystem.listFilesRecursive x)))
          [ ../lib ../modules ./${name} ];
          specialArgs.inputs = inputs;
        }
    );
in {
  flake.nixosConfigurations = mkMerge [
    (withSystem "x86_64-linux" (
      _: genHosts [ "aoi" "ena" "rin" "ryo" ]
    ))
  ];
}
