{
  inputs,
  withSystem,
  ...
}: let
  inherit (inputs.nixpkgs.lib) genAttrs nixosSystem hasSuffix filesystem;
  genHosts = hosts:
    genAttrs hosts (
      name:
        withSystem "x86_64-linux" (_:
          nixosSystem {
            modules = builtins.concatMap (x:
              builtins.filter (hasSuffix ".nix")
              (map toString (filesystem.listFilesRecursive x)))
            [../lib ../modules ./${name}];
            specialArgs = {inherit inputs;};
          })
    );
in {
  flake.nixosConfigurations = genHosts [
    "aoi"
    "ena"
    "rin"
    "ryo"
  ];
}
