{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  #### awaiting pr
  imports = ["${inputs.qbit}/nixos/modules/services/torrent/qbittorrent.nix"];
  ####
  options.cute.services.web.qbittorrent = lib.mkEnableOption "";
  config = let
    domain = "qbit.${config.cute.services.web.domain}";
    webport = 8077;
    tport = 43862;
  in
    lib.mkIf config.cute.services.web.qbittorrent {
      services = {
        qbittorrent = {
          enable = true;
          profileDir = "/storage/services/qbit/profile";
          package = pkgs.qbittorrent-nox.overrideAttrs {meta.mainProgram = "qbittorrent-nox";};
          serverConfig = {
            LegalNotice.Accepted = true;
            BitTorrent.Session = {
              Port = tport;
              DefaultSavePath = "/storage/services/qbit/torrents";
              TorrentExportDirectory = "/storage/services/qbit/torrents/sources/";
              TempPath = "/storage/services/qbit/torrents/incomplete/";
              TempPathEnabled = true;
              QueueingSystemEnabled = true;
              IgnoreSlowTorrentsForQueueing = true;
              GlobalMaxRatio = 2;
              MaxActiveCheckingTorrents = 2;
              MaxActiveDownloads = 5;
              MaxConnections = 600;
            };
            Preferences = {
              WebUI = let
                vue = pkgs.fetchzip {
                  url = "https://github.com/VueTorrent/VueTorrent/releases/download/v2.5.0/vuetorrent.zip";
                  hash = "sha256-ys9CrbpOPYu8xJsCnqYKyC4IFD/SSAF8j+T+USqvGA8=";
                };
              in {
                AlternativeUIEnabled = true;
                RootFolder = vue;
                Port = webport;
                Username = "pagu";
                Password_PBKDF2 = ''"@ByteArray(kZipcTwDuigp5wDRkynNQA==:roLYJRl9n/jcGRTXzgont6GAsBm7Bu7LGfrUfB7QcQqgQRSOLNvBs9YrC6h8nMgN/4e4dDETmAQGF16S+zBD5Q==)"'';
                ReverseProxySupportEnabled = true;
                TrustedReverseProxiesList = "${domain}";
              };
              General.Locale = "en";
            };
          };
        };
        nginx.virtualHosts."${domain}" = {
          forceSSL = true;
          enableACME = true;
          locations."/".proxyPass = "http://0.0.0.0:${toString webport}";
        };
      };
      users.users.qbittorrent.extraGroups = ["media"];
      networking.firewall = {
        allowedTCPPorts = [webport tport];
        allowedUDPPorts = [tport];
      };
    };
}
