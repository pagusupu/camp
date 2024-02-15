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
	package = pkgs.firefox.override { cfg.speechSynthesisSupport = false; };
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
            "treestyletab@piro.sakura.ne.jp" = {
              installation_mode = "force_installed";
              install_url = "https://addons.mozilla.org/firefox/downloads/file/4197314/tree_style_tab-3.9.19.xpi";
            };
            "" = {
              installation_mode = "force_installed";
              install_url = "https://addons.mozilla.org/firefox/downloads/file/4208483/return_youtube_dislikes-3.0.0.14.xpi";
            };
          };
        };
      };
      home = {
	packages = [pkgs.libnotify];
	sessionVariables = {MOZ_ENABLE_WAYLAND = 1;};
      };
    };
  };
}