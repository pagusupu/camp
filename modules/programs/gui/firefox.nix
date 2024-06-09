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
        "gfx.webrender.all" = true;
        "privacy.firstparty.isolate" = true;
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
        DownloadDirectory = lib.mkIf (config.cute.desktop.env.misc == false) "/home/pagu/downloads";
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
          c = {
            Title = "";
            Placement = "toolbar";
          };
        in [
          ({URL = "https://discord.com/channels/@me";} // c)
          ({URL = "https://ciny.pagu.cafe";} // c)
          ({URL = "https://link.pagu.cafe/bookmarks";} // c)
        ];
        ExtensionSettings = let
          extension = u: l: {
            name = u;
            value = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/${l}/latest.xpi";
              default_area = "menupanel";
              installation_mode = "force_installed";
              updates_disabled = false;
            };
          };
        in
          builtins.listToAttrs [
            (extension "{446900e4-71c2-419f-a6a7-df9c091e268b}" "bitwarden-password-manager")
            (extension "{61a05c39-ad45-4086-946f-32adb0a40a9d}" "linkding-extension")
            (extension "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" "return-youtube-dislikes")
            (extension "sponsorBlocker@ajay.app" "sponsorblock")
            (extension "treestyletab@piro.sakura.ne.jp" "tree-style-tab")
            (extension "uBlock0@raymondhill.net" "ublock-origin")
          ];
        "3rdparty".Extensions = {
          "uBlock0@raymondhill.net".adminSettings = {
            userSettings = {
              cloudStorageEnabled = false;
              importedLists = ["https://raw.githubusercontent.com/laylavish/uBlockOrigin-HUGE-AI-Blocklist/main/list.txt"];
            };
            selectedFilterLists = [
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
            ];
          };
        };
      };
    };
    homefile."profiles" = {
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
    hardware.opengl.extraPackages = [
      pkgs.libvdpau-va-gl
      pkgs.vaapiVdpau
    ];
    environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  };
}
