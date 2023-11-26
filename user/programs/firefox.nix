{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.programs.firefox = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.firefox.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-esr-unwrapped {
        extraPolicies = {
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
            TopSite = false;
            Highlights = false;
            Locked = true;
          };
          UserMessaging = {
            ExtensionRecommendations = false;
            SkipOnboarding = true;
          };
          Cookies = {
            Behavior = "accept";
            ExpireAtSessionEnd = false;
            Locked = false;
          };
        };
        extraPrefs = ''
          lockPref("gfx.webrender.all", true);
          lockPref("browser.aboutConfig.showWarning", true);
          lockPref("browser.tabs.firefox-view", true);
          lockPref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          lockPref("privacy.firstparty.isolate", true);
          lockPref("browser.EULA.override", true);
          lockPref("browser.tabs.inTitlebar", 0);
        '';
       # nixExtensions = [
       #   (pkgs.fetchFirefoxAddon {
       #     name = "ublock";
       #     url = "https://addons.mozilla.org/firefox/downloads/file/4171020/ublock_origin-1.52.2.xpi";
        #    hash = "sha256-6O4/nVl6bULbnXP+h8HVId40B1X9i/3WnkFiPt/gltY=";
        #  })
        #  (pkgs.fetchFirefoxAddon {
        #    name = "sponsorblock";
        #    url = "https://addons.mozilla.org/firefox/downloads/file/4178444/sponsorblock-5.4.23.xpi";
        #    hash = "sha256-uSSrb7zS8QKsY6pzfe48kIYNDxr+p0PGsPu2l6oImDI=";
        #  })
        #  (pkgs.fetchFirefoxAddon {
        #    name = "treestyletab";
        #    url = "https://addons.mozilla.org/firefox/downloads/file/4164980/tree_style_tab-3.9.17.xpi";
        #    hash = "sha256-Tc9w9WQ2RldJxMeHoLupD+Kjm/TAz5H6f3zSovioBvU=";
        #  })
        #  (pkgs.fetchFirefoxAddon {
        #    name = "bitwarden";
        #    url = "https://addons.mozilla.org/firefox/downloads/file/4191732/bitwarden_password_manager-2023.10.2.xpi";
        #    hash = "";
        #  })
        #];
      };
      profiles."pagu" = {
        id = 0;
        name = "pagu";
        settings = {
          "browser.bookmarks.default.location" = "toolbar";
        };
        search = {
          default = "DuckDuckGo";
          force = true;
          order = [
            "DuckDuckGo"
            "Google"
            "Nix Packages"
            "Nix Options"
          ];
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
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
            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "options";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
            };
            "Bing".metaData.hidden = true;
            "Amazon.com".metaData.hidden = true;
            "Wikipedia (en)".metaData.hidden = true;
          };
        };
      };
    };
  };
}
