{
  config,
  lib,
  ...
}: {
  options.cute.services.gitea = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.services.gitea.enable {
    services.gitea = {
      enable = true;
      settings = {
        ui = {
          DEFAULT_THEME = "arc-green";
        };
        service = {
          DISABLE_REGSTRATION = true;
        };
        server = {
          ROOT_URL = "https://tea.pagu.cafe";
          HTTP_PORT = 8333;
          DOMAIN = "tea.pagu.cafe";
          LANDING_PAGE = "/explore/repos";
        };
        session.COOKIE_SECURE = true;
      };
      stateDir = "/mnt/storage/services/gitea";
    };
  };
}
