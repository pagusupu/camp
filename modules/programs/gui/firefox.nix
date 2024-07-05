{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cute.programs.gui.firefox = lib.mkEnableOption "";
  config = lib.mkIf config.cute.programs.gui.firefox {
    home-manager.users.pagu = {
      programs.firefox = {
        enable = true;
        package = pkgs.firefox.override {cfg.speechSynthesisSupport = false;};
        profiles.pagu = {
          settings = {
            "browser.aboutConfig.showWarning" = false;
            "browser.EULA.override" = true;
            "gfx.webrender.all" = true;
            "privacy.firstparty.isolate" = true;
          };
          search = {
            force = true;
            default = "Google";
            order = [
              "Google"
              "DuckDuckGo"
              "Nix Packages"
            ];
            engines = {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages?channel=unstable";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["@np"];
              };
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
          DisplayBookmarksToolbar = "newtab";
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
          Bookmarks = let
            b = l: {
              URL = l;
              Title = "";
              Placement = "toolbar";
            };
          in [
            (b "https://discord.com/channels/@me")
            (b "https://ciny.pagu.cafe")
            (b "http://192.168.178.182:9090")
          ];
          ExtensionSettings = let
            e = n: l: {
              name = n;
              value = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/${l}/latest.xpi";
                default_area = "menupanel";
                installation_mode = "force_installed";
                updates_disabled = false;
              };
            };
          in
            builtins.listToAttrs [
              (e "{446900e4-71c2-419f-a6a7-df9c091e268b}" "bitwarden-password-manager")
              (e "{61a05c39-ad45-4086-946f-32adb0a40a9d}" "linkding-extension")
              (e "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" "return-youtube-dislikes")
              (e "sponsorBlocker@ajay.app" "sponsorblock")
              (e "treestyletab@piro.sakura.ne.jp" "tree-style-tab")
              (e "uBlock0@raymondhill.net" "ublock-origin")
            ];
          "3rdparty".Extensions."uBlock0@raymondhill.net" = {
            userSettings.cloudStorageEnabled = false;
            adminSettings.selectedFilterLists = [
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
    hardware.graphics.extraPackages = [
      pkgs.libvdpau-va-gl
      pkgs.vaapiVdpau
    ];
    environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  };
}
