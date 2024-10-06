{
  config,
  lib,
  cutelib,
  pkgs,
  inputs,
  ...
}: {
  options.cute.programs.firefox = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.firefox {
    assertions = cutelib.assertHm "firefox";
    home-manager.users.pagu = {
      programs.firefox = {
        enable = true;
        package = pkgs.firefox.override {cfg.speechSynthesisSupport = false;};
        profiles.pagu = {
          extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
            bitwarden
            darkreader
            linkding-extension
            return-youtube-dislikes
            sponsorblock
            tree-style-tab
          ];
          settings = {
            "browser.startup.homepage" = "http://192.168.178.82:8333";
            "browser.aboutConfig.showWarning" = false;
            "browser.EULA.override" = true;
            "extensions.webextensions.restrictedDomains" = "";
            "gfx.webrender.all" = true;
            "privacy.firstparty.isolate" = true;
            "privacy.resistFingerprinting.block_mozAddonManager" = true;
          };
          search = {
            force = true;
            default = "DuckDuckGo";
            order = [
              "DuckDuckGo"
              "Google"
            ];
            engines = {
              "Amazon.com".metaData.hidden = true;
              "Bing".metaData.hidden = true;
              "eBay".metaData.hidden = true;
              "Wikipedia (en)".metaData.hidden = true;
            };
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
          DisableTelemetry = true;
          DisplayBookmarksToolbar = "never";
          DontCheckDefaultBrowser = true;
          HardwareAcceleration = true;
          NoDefaultBookmarks = true;
          PasswordManagerEnabled = false;
          Cookies = {
            Behavior = "accept";
            Locked = false;
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
          "3rdparty".Extensions = {
            "addon@darkreader.org" = {
              enabled = true;
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
              "adguard-generic"
              "adguard-mobile"
              "easyprivacy"
              "adguard-spyware"
              "adguard-spyware-url"
              "block-lan"
              "urlhaus-1"
              "curben-phishing"
              "plowe-0"
              "dpollock-0"
              "fanboy-cookiemonster"
              "ublock-cookies-easylist"
              "adguard-cookies"
              "ublock-cookies-adguard"
              "fanboy-social"
              "adguard-social"
              "fanboy-thirdparty_social"
              "easylist-chat"
              "easylist-newsletters"
              "easylist-notifications"
              "easylist-annoyances"
              "adguard-mobile-app-banners"
              "adguard-other-annoyances"
              "adguard-popup-overlays"
              "adguard-widgets"
              "ublock-annoyances"
              "https://raw.githubusercontent.com/laylavish/uBlockOrigin-HUGE-AI-Blocklist/main/list.txt"
            ];
          };
        };
      };
    };
    hardware.graphics.extraPackages = with pkgs; [
      libvdpau-va-gl
      vaapiVdpau
    ];
    environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  };
}
