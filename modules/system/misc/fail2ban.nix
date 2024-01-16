{
  config,
  lib,
  ...
}: {
  options.cute.system.misc.fail2ban.enable = lib.mkEnableOption "";
  config = lib.mkIf config.cute.system.misc.fail2ban.enable {
    services.fail2ban = {
      enable = true;
      bantime-increment = {
        enable = true;
        factor = "16";
      };
    };
  };
}
