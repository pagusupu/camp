{
  config,
  lib,
  cutelib,
  inputs,
  pkgs,
  ...
}: {
  options.cute.programs.gui.floorp = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.gui.floorp {
    assertions = cutelib.assertHm "floorp";
    home-manager.users.pagu = {
      programs.floorp = {
        enable = true;
        package = pkgs.floorp.override { cfg.speechSynthesisSupport = false; };
        profiles.pagu = {
          extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
            bitwarden
            darkreader
            facebook-container
            linkding-extension
            return-youtube-dislikes
            sponsorblock
            tree-style-tab
            ublock-origin
          ];
          settings = {
            "browser.startup.homepage" = "http://localhost:8333";
            "browser.aboutConfig.showWarning" = false;
            "browser.EULA.override" = true;
            "extensions.webextensions.restrictedDomains" = "";
            "gfx.webrender.all" = true;
            "privacy.firstparty.isolate" = true;
            "privacy.resistFingerprinting.block_mozAddonManager" = true;
          };
          search = {
            default = "DuckDuckGo";
            order = [
              "DuckDuckGo"
              "Google"
            ];
            engines = {
              "Bing".metaData.hidden = true;
              "Startpage".metaData.hidden = true;
              "You.com".metaData.hidden = true;
            };
            force = true;
          };
        };
        policies = {
          CaptivePortal = false;
          DisableFeedbackCommands = true;
          DisableFirefoxAccounts = true;
          DisableFirefoxScreenshots = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableProfileImport = true;
          DisableProfileRefresh = true;
          DisableSetDesktopBackground = true;
          DisplayBookmarksToolbar = "never";
          DontCheckDefaultBrowser = true;
          HardwareAcceleration = true;
          NoDefaultBookmarks = true;
          PasswordManagerEnabled = false;
          Cookies = {
            Behavior = "reject-tracker-and-partition-foreign";
            Locked = true;
          };
          FirefoxHome = {
            Highlights = false;
            Pocket = false;
            Snippets = false;
            TopSites = false;
            Locked = true;
          };
          FirefoxSuggest = {
            ImproveSuggest = false;
            SponsoredSugRegexgestions = false;
            WebSuggestions = true;
            Locked = true;
          };
          UserMessaging = {
            ExtensionRecommendations = false;
            FeatureRecommendations = false;
            MoreFromMozilla = false;
            SkipOnboarding = true;
            WhatsNew = false;
            Locked = true;
          };
          SanitizeOnShutdown = {
            Cache = false;
            Cookies = false;
            History = false;
            Sessions = true;
            SiteSettings = false;
            OfflineApps = true;
            Locked = true;
          };
          "3rdparty".Extensions = {
            "addon@darkreader.org" = {
              automation = {
                enabled = true;
                behavior = "OnOff";
                mode = "system";
              };
              detectDarkTheme = true;
              enabledByDefault = false;
              enableForProtectedPages = true;
              fetchNews = false;
              previewNewDesign = true;
              syncSettings = false;
            };
            "uBlock0@raymondhill.net".adminSettings.selectedFilterLists = [
              "user-filters"
              "ublock-filters"
              "ublock-badware"
              "ublock-privacy"
              "ublock-quick-fixes"
              "ublock-unbreak"
              "easylist"
              "easyprivacy"
              "adguard-spyware-url"
              "urlhaus-1"
              "plowe-0"
              "fanboy-cookiemonster"
              "ublock-cookies-easylist"
              "fanboy-social"
              "easylist-chat"
              "easylist-newsletters"
              "easylist-notifications"
              "easylist-annoyances"
              "ublock-annoyances"
              "https://raw.githubusercontent.com/DandelionSprout/adfilt/refs/heads/master/LegitimateURLShortener.txt"
              "https://raw.githubusercontent.com/laylavish/uBlockOrigin-HUGE-AI-Blocklist/main/list.txt"
            ];
          };
        };
      };
    };
    environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  };
}
