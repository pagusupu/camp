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
                widgets = [
                  {
                    type = "bookmarks";
                    groups = [
                      {
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
                            title = "Grafana";
                            url = "http://aoi:8090";
                            same-tab = true;
                          }
                        ];
                      }
                      {
                        links = [
                          {
                            title = "Nix Search";
                            url = "https://search.nixos.org/packages?channel=unstable";
                            same-tab = true;
                          }
                          {
                            title = "HM Search";
                            url = "https://home-manager-options.extranix.com/?query=sefsef&release=master";
                            same-tab = true;
                          }
                          {
                            title = "Tailscale";
                            url = "https://login.tailscale.com/admin/machines";
                            same-tab = true;
                          }
                        ];
                      }
                      {
                        links = [
                          {
                            title = "GitHub";
                            url = "https://github.com";
                            same-tab = true;
                          }

                          {
                            title = "Youtube";
                            url = "https://youtube.com/feed/subscriptions";
                            same-tab = true;
                          }
                          {
                            title = "Proton Mail";
                            url = "https://mail.proton.me";
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
                        url = "https://frss.pagu.cafe";
                        icon = "si:rss";
                        same-tab = true;
                      }
                      {
                        title = "qBittorrent";
                        url = "https://qbit.pagu.cafe";
                        icon = "si:qbittorrent";
                        same-tab = true;
                      }
                      {
                        title = "Immich";
                        url = "http://aoi:3001";
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
          primary-color = mkDefault "343 35 55"; # love
          positive-color = mkDefault "189 30 48"; # foam
          negative-color = mkDefault "3 53 67"; # rose
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
