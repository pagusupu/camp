{
  lib,
  config,
  ...
}: {
  options.cute.hm.programs.firefox.enable = lib.mkEnableOption "";
  config = lib.mkIf config.cute.hm.programs.firefox.enable {
    programs.firefox = {
      enable = true;
      policies = {
        Preferences = {
          "gfx.webrender.all" = true;
          "browser.aboutConfig.showWarning" = true;
          "browser.tabs.firefox-view" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "privacy.firstparty.isolate" = true;
          "browser.EULA.override" = true;
          "browser.tabs.inTitlebar" = 0;
        };
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableSetDesktopBackground = true;
        DisableFeedbackCommands = true;
        DisableFirefoxScreenshots = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        PasswordManagerEnabled = false;
        FirefoxHome = {
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Highlights = false;
          Locked = true;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
        Cookies = {
          Behavior = "accept";
          Locked = false;
        };
        ExtensionSettings = {
          "*" = {
            default_area = "menupanel";
          };
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4188488/ublock_origin-1.53.0.xpi";
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4180072/bitwarden_password_manager-2023.9.2.xpi";
          };
          "sponsorBlocker@ajay.app" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4178444/sponsorblock-5.4.23.xpi";
          };
          "" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4208483/return_youtube_dislikes-3.0.0.14.xpi";
          };
        };
      };
      profiles."pagu" = {
        id = 0;
        name = "pagu";
        search = {
          default = "DuckDuckGo";
          force = true;
          order = [
            "DuckDuckGo"
            "Google"
          ];
          engines = {
            "Bing".metaData.hidden = true;
            "Amazon.com".metaData.hidden = true;
            "Wikipedia (en)".metaData.hidden = true;
          };
        };
      };
    };
  };
}
