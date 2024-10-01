{
  config,
  lib,
  cutelib,
  inputs,
  ...
}: {
  imports = [inputs.comin.nixosModules.comin];
  options.cute.services.comin = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.comin {
    services.comin = {
      enable = true;
      remotes = [
        {
          name = "local";
          url = "/home/pagu/camp";
          poller.period = 5;
        }
      ];
    };
  };
}
