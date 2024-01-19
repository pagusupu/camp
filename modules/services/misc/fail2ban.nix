{
  config,
  lib,
  ...
}: {
  options.cute.services.misc.fail2ban = lib.mkEnableOption "";
  config = lib.mkIf config.cute.services.misc.fail2ban {
    services.fail2ban = {
      enable = true;
      bantime-increment = {
        enable = true;
        factor = "16";
      };
    };
  };
}
