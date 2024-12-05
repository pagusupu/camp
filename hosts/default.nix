{
  inputs,
  withSystem,
  ...
}: let
  inherit (inputs.nixpkgs.lib) genAttrs nixosSystem hasSuffix filesystem;
  genHosts = hosts:
    genAttrs hosts (
      name:
        nixosSystem {
          modules = builtins.concatMap (x:
            builtins.filter (hasSuffix ".nix")
            (map toString (filesystem.listFilesRecursive x)))
          [ ./${name} ../modules ../parts/lib ];
          specialArgs.inputs = inputs;
        }
    );
in {
  flake.nixosConfigurations = withSystem "x86_64-linux" (
    _: genHosts [ "aoi" "ena" "rin" "ryo" ]
  );
}
