{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];
  nixpkgs.overlays = [inputs.nix-minecraft.overlay];
  services.minecraft-servers = {
    enable = true;
    openFirewall = true;
    eula = true;
    dataDir = /storage/services/minecraft;
    servers.test = {
      enable = true;
      autoStart = false;
      restart = "no";
      package = pkgs.vanillaServers.vanilla;
      serverProperties = {
        server-ip = "0.0.0.0";
      };
    };
  };
  environment.systemPackages = [pkgs.tmux];
  users.users.pagu.extraGroups = ["minecraft"];
}
