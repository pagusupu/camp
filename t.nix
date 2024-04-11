{
  lib,
  config,
  ...
}: {
  options.cute.common = {
    
    ssh = lib.mkEnableOption "";
    
  };
  config = let
    inherit (config.cute.common) ssh ;
  in {
    
    services.openssh = lib.mkIf ssh {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };
}
