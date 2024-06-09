{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];
  options.cute.services.minecraft = lib.mkEnableOption "";
  config = lib.mkIf config.cute.services.minecraft {
    nixpkgs.overlays = [inputs.nix-minecraft.overlay];
    services.minecraft-servers = {
      enable = true;
      openFirewall = true;
      eula = true;
      #dataDir = /storage/services/minecraft;
      servers.vanilla = {
        enable = true;
        package = pkgs.vanillaServers.vanilla-1_20_6;
        autoStart = false;
        restart = "no";
        serverProperties = {
          motd = "Vanilla 1.20.6";
          server-port = 25555;
        };
      };
    };
    environment.systemPackages = [pkgs.tmux];
    users.users.pagu.extraGroups = ["minecraft"];
  };
}
