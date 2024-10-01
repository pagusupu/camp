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
          name = "origin";
          url = "https://github.com/pagusupu/camp.git";
        }
      ];
    };
  };
}
