{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.local.glance = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.local.glance {
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
                          (bookmark "Feishin" "http://192.168.178.182:9180")
                          (bookmark "Linkding" "http://192.168.178.182:9090")
                          (bookmark "Memos" "http://192.168.178.182:5230")
                          (bookmark "Youtube" "https://youtube.com/feed/subscriptions")
                          (bookmark "YT Music" "https://music.youtube.com")
                        ];
                      }
                      {
                        title = "Misc";
                        links = [
                          (bookmark "Nix Search" "https://search.nixos.org/packages?channel=24.11")
                          (bookmark "HM Search" "https://home-manager-options.extranix.com/?query=&release=release-24.11")
                          (bookmark "GitHub" "https://github.com")
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
                      (service "Jellyfin" "http://192.168.178.182:8096" "si:jellyfin")
                      (service "Navidrome" "http://192.168.178.182:8098" "si:soundcloud")
                      (service "FreshRSS" "https://frss.pagu.cafe" "si:rss")
                      (service "qBittorrent" "http://192.168.178.182:8077" "si:qbittorrent")
                      (service "Immich" "http://192.168.178.182:3001" "si:immich")
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
        theme = let
          inherit (lib) mkDefault;
        in {
          light = mkDefault true;
          background-color = mkDefault "32 57 95"; # base
          primary-color = mkDefault "268 21 57"; # iris
          positive-color = mkDefault "189 30 48"; # foam
          negative-color = mkDefault "343 35 55"; # love
        };
        branding.hide-footer = true;
      };
    };
    specialisation.dark.configuration = {
      services.glance.settings.theme = {
        light = false;
        background-color = "249 22 12";
        primary-color = "267 57 78";
        positive-color = "189 43 73";
        negative-color = "343 76 68";
      };
    };
  };
}
