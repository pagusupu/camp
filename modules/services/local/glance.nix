{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.web.glance = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.web.glance {
    services.glance = {
      enable = true;
      openFirewall = true;
      settings = {
        server = {
          port = 8333;
          host = "0.0.0.0";
        };
        pages = [
          {
            columns = [
              {
                widgets = [
                  {
                    type = "clock";
                    hour-format = "12h";
                    timezones = let
                      zone = timezone: label: { inherit timezone label; };
                    in [
                      (zone "US/Central" "US/Central")
                      (zone "Europe/London" "London")
                      (zone "Asia/Tokyo" "Tokyo")
                      (zone "Australia/Sydney" "Sydney")
                    ];
                  }
                  { type = "calendar"; }
                ];
                size = "small";
              }
              {
                widgets = [
                  {
                    type = "bookmarks";
                    groups = let
                      bookmark = title: url: {
                        inherit title url;
                        same-tab = true;
                      };
                    in [
                      {
                        title = "Frequent";
                        links = [
                          (bookmark "Discord" "https://discord.com/channels/@me")
                          (bookmark "Feishin" "http://aoi:9180")
                          (bookmark "Linkding" "http://aoi:9090")
                          (bookmark "Memos" "http://aoi:5230")
                          (bookmark "Youtube" "https://youtube.com/feed/subscriptions")
                          (bookmark "YT Music" "https://music.youtube.com")
                        ];
                      }
                      {
                        title = "Misc";
                        links = [
                          (bookmark "Flathub" "https://flathub.org/")
                          (bookmark "Nix Search" "https://search.nixos.org/packages?channel=24.11")
                          (bookmark "HM Search" "https://home-manager-options.extranix.com/?query=&release=release-24.11")
                          (bookmark "Tailscale" "https://login.tailscale.com/admin/machines")
                          (bookmark "Gmail" "https://mail.google.com/mail/u/0/")
                          (bookmark "Proton Mail" "https://mail.proton.me/u/0/inbox")
                        ];
                      }
                    ];
                  }
                  {
                    type = "monitor";
                    sites = let
                      service = title: url: icon: {
                        inherit title url icon;
                        same-tab = true;
                      };
                    in [
                      (service "Jellyfin" "http://aoi:8096" "si:jellyfin")
                      (service "Navidrome" "http://aoi:8098" "si:soundcloud")
                      (service "FreshRSS" "https://frss.pagu.cafe" "si:rss")
                      (service "qBittorrent" "http://aoi:8077" "si:qbittorrent")
                      (service "Immich" "http://aoi:3001" "si:immich")
                      (service "Vaultwarden" "https://wrdn.pagu.cafe" "si:vaultwarden")
                    ];
                    cache = "1m";
                    title = "Services";
                  }
                ];
                size = "full";
              }
            ];
            name = "Home";
            width = "slim";
            hide-desktop-navigation = true;
            center-vertically = true;
          }
        ];
        theme = {
          light = false;
          background-color = "229 19 23";
          primary-color = "277 59 76";
          positive-color = "96 44 68";
          negative-color = "359 68 71";
        };
        branding.hide-footer = true;
      };
    };
  };
}
