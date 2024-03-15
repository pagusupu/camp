{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cute.desktop.firefox = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.firefox {
    home-manager.users.pagu = {
      programs.firefox = {
        enable = true;
        profiles."pagu" = {
          id = 0;
          name = "pagu";
          settings = {
            "gfx.webrender.all" = true;
            "browser.aboutConfig.showWarning" = false;
            "browser.tabs.firefox-view" = true;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "privacy.firstparty.isolate" = true;
            "browser.EULA.override" = true;
            "browser.tabs.inTitlebar" = 0;
            "browser.startup.homepage" = "https://dash.pagu.cafe";
          };
          search = {
            force = true;
            default = "DuckDuckGo";
            order = ["DuckDuckGo" "Google"];
            engines = {
              "Bing".metaData.hidden = true;
              "Amazon.com".metaData.hidden = true;
              "Wikipedia (en)".metaData.hidden = true;
            };
          };
        };
        package = pkgs.firefox.override {cfg.speechSynthesisSupport = false;};
        policies = {
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
          Cookies = {
            Behavior = "accept";
            Locked = false;
          };
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
          ExtensionSettings = {
            "*" = {
              default_area = "menupanel";
              installation_mode = "force_installed";
              updates_disabled = false;
            };
            "{446900e4-71c2-419f-a6a7-df9c091e268b}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            "{762f9885-5a13-4abd-9c77-433dcd38b8fd}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
            "sponsorBlocker@ajay.app".install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
            "treestyletab@piro.sakura.ne.jp".install_url = "https://addons.mozilla.org/firefox/downloads/latest/tree-style-tab/latest.xpi";
            "uBlock0@raymondhill.net".install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          };
        };
      };
      home.sessionVariables = {MOZ_ENABLE_WAYLAND = 1;};
    };
  };
}
