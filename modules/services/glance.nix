{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.glance = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.glance {
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
                widgets = let
                  #inherit (config.cute.net) ip;
                  inherit (config.networking) domain;
                in [
                  {
                    type = "search";
                    autofocus = true;
                  }
                  {
                    type = "monitor";
                    sites = [
                      {
                        title = "Jellyfin";
                        url = "http://aoi:8096";
                        icon = "si:jellyfin";
                        same-tab = true;
                      }
                      {
                        title = "Navidrome";
                        url = "http://aoi:8098";
                        icon = "si:soundcloud";
                        same-tab = true;
                      }
                      {
                        title = "FreshRSS";
                        url = "https://frss.${domain}";
                        icon = "si:rss";
                        same-tab = true;
                      }
                      {
                        title = "qBittorrent";
                        url = "http://aoi:8077";
                        icon = "si:qbittorrent";
                        same-tab = true;
                      }
                      {
                        title = "Immich";
                        url = "https://meal.${domain}";
                        icon = "si:immich";
                        same-tab = true;
                      }
                      {
                        title = "Vaultwarden";
                        url = "https://wrdn.${domain}";
                        icon = "si:vaultwarden";
                        same-tab = true;
                      }
                    ];
                    cache = "1m";
                    title = "Services";
                  }
                  {
                    type = "bookmarks";
                    groups = [
                      {
                        title = "Default";
                        links = [
                          {
                            title = "Discord";
                            url = "https://discord.com/channels/@me";
                            same-tab = true;
                          }
                          {
                            title = "Element";
                            url = "https://chat.${domain}";
                            same-tab = true;
                          }
                          {
                            title = "Feishin";
                            url = "http://aoi:9180";
                            same-tab = true;
                          }
                        ];
                      }
                      {
                        title = "Frequent";
                        links = [
                          {
                            title = "Linkding";
                            url = "http://aoi:9090";
                            same-tab = true;
                          }
                          {
                            title = "Memos";
                            url = "http://aoi:5230";
                            same-tab = true;
                          }
                          {
                            title = "Proton Mail";
                            url = "https://mail.proton.me";
                            same-tab = true;
                          }
                        ];
                      }
                      {
                        title = "Misc";
                        links = [
                          {
                            title = "Nix Search";
                            url = "https://search.nixos.org/packages?channel=unstable";
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
                        ];
                      }
                    ];
                  }
                ];
                size = "full";
              }
            ];
            name = "Startpage";
            width = "slim";
            hide-desktop-navigation = true;
            center-vertically = true;
          }
        ];
        theme = {
          light = lib.mkDefault true;
          background-color = lib.mkDefault "32 57 95"; # base
          primary-color = lib.mkDefault "343 35 55"; # love
          positive-color = lib.mkDefault "189 30 48"; # foam
          negative-color = lib.mkDefault "3 53 67"; # rose
        };
        branding.hide-footer = true;
      };
    };
    specialisation.dark.configuration = {
      services.glance.settings.theme = {
        light = false;
        background-color = "246 24 17";
        primary-color = "343 76 68";
        positive-color = "189 43 73";
        negative-color = "2 66 75";
      };
    };
  };
}
