{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.cloud.syncthing = cutelib.mkEnable;
  config = let
    port = 8384;
  in
    lib.mkIf config.cute.services.cloud.syncthing {
      services.syncthing = {
        enable = true;
        overrideDevices = false;
        overrideFolders = false;
        guiAddress = "0.0.0.0:${builtins.toString port}";
        settings.gui = {
          user = "pagu";
          password = "changeme";
        };
        openDefaultPorts = true;
      };
      networking.firewall = {
        allowedTCPPorts = [ port 22000 ];
        allowedUDPPorts = [ 22000 21027 ];
      };
    };
}
