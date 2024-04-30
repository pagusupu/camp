{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cute.programs.gui.firefox = lib.mkEnableOption "";
  config = lib.mkIf config.cute.programs.gui.firefox {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-wayland.override {cfg.speechSynthesisSupport = false;};
      preferences = {
        "browser.aboutConfig.showWarning" = false;
        "browser.EULA.override" = true;
        "privacy.firstparty.isolate" = true;
        "gfx.webrender.all" = true;
      };
      policies = {
        CaptivePortal = false;
        DisableFeedbackCommands = true;
        DisableFirefoxScreenshots = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        PasswordManagerEnabled = false;
        Cookies = {
          Behavior = "accept";
          Locked = false;
        };
        FirefoxHome = {
          Highlights = false;
          Locked = true;
          Pocket = false;
          Snippets = false;
          TopSites = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
        ExtensionSettings = let
          link = "https://addons.mozilla.org/firefox/downloads/latest/";
          xpi = "/latest.xpi";
          common = {
            default_area = "menupanel";
            installation_mode = "normal_installed";
            updates_disabled = false;
          };
        in {
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "${link}bitwarden-password-manager${xpi}";
            inherit common;
          };
          "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
            install_url = "${link}return-youtube-dislikes${xpi}";
            inherit common;
          };
          "sponsorBlocker@ajay.app" = {
            install_url = "${link}sponsorblock${xpi}";
            inherit common;
          };
          "treestyletab@piro.sakura.ne.jp" = {
            install_url = "${link}tree-style-tab${xpi}";
            inherit common;
          };
          "uBlock0@raymondhill.net" = {
            install_url = "${link}ublock-origin${xpi}";
            inherit common;
          };
        };
      };
    };
    home.file."profiles" = {
      target = ".mozilla/firefox/profiles.ini";
      source = (pkgs.formats.ini {}).generate "profiles.ini" {
        General = {
          StartWithLastProfile = 1;
          Version = 2;
        };
        Profile0 = {
          Default = 1;
          IsRelative = 1;
          Name = "pagu";
          Path = "pagu";
        };
      };
    };
    hardware.opengl.extraPackages = builtins.attrValues {
      inherit (pkgs) vaapiVdpau libvdpau-va-gl;
    };
    environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  };
}
