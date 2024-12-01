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
                    timezones = [
                      {
                        timezone = "US/Central";
                        label = "US Central";
                      }
                      {
                        timezone = "Europe/London";
                        label = "London";
                      }
                      {
                        timezone = "Asia/Tokyo";
                        label = "Tokyo";
                      }
                      {
                        timezone = "Australia/Sydney";
                        label = "Sydney";
                      }
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
                    groups = [
                      {
                        title = "Frequent";
                        links = [
                          {
                            title = "Discord";
                            url = "https://discord.com/channels/@me";
                            same-tab = true;
                          }
                          {
                            title = "Feishin";
                            url = "http://192.168.178.182:9180";
                            same-tab = true;
                          }
                          {
                            title = "Linkding";
                            url = "http://192.168.178.182:9090";
                            same-tab = true;
                          }

                          {
                            title = "Memos";
                            url = "http://192.168.178.182:5230";
                            same-tab = true;
                          }

                          {
                            title = "Youtube";
                            url = "https://youtube.com/feed/subscriptions";
                            same-tab = true;
                          }
                          {
                            title = "YT Music";
                            url = "https://music.youtube.com";
                            same-tab = true;
                          }
                        ];
                      }
                      {
                        title = "Misc";
                        links = [
                          {
                            title = "Nix Search";
                            url = "https://search.nixos.org/packages?channel=24.11";
                            same-tab = true;
                          }
                          {
                            title = "HM Search";
                            url = "https://home-manager-options.extranix.com/?release=24.11";
                            same-tab = true;
                          }
                          {
                            title = "GitHub";
                            url = "https://github.com";
                            same-tab = true;
                          }
                          {
                            title = "Tailscale";
                            url = "https://login.tailscale.com/admin/machines";
                            same-tab = true;
                          }
                          {
                            title = "Gmail";
                            url = "https://mail.google.com/mail/u/0/";
                            same-tab = true;
                          }
                          {
                            title = "Proton Mail";
                            url = "https://mail.proton.me/u/0/inbox";
                            same-tab = true;
                          }
                        ];
                      }
                    ];
                  }
                  {
                    type = "monitor";
                    sites = [
                      {
                        title = "Jellyfin";
                        url = "http://192.168.178.182:8096";
                        icon = "si:jellyfin";
                        same-tab = true;
                      }
                      {
                        title = "Navidrome";
                        url = "http://192.168.178.182:8098";
                        icon = "si:soundcloud";
                        same-tab = true;
                      }
                      {
                        title = "FreshRSS";
                        url = "https://frss.pagu.cafe";
                        icon = "si:rss";
                        same-tab = true;
                      }
                      {
                        title = "qBittorrent";
                        url = "http://192.168.178.182:8077";
                        icon = "si:qbittorrent";
                        same-tab = true;
                      }
                      {
                        title = "Immich";
                        url = "http://192.168.178.182:3001";
                        icon = "si:immich";
                        same-tab = true;
                      }
                      {
                        title = "Vaultwarden";
                        url = "https://wrdn.pagu.cafe";
                        icon = "si:vaultwarden";
                        same-tab = true;
                      }
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
