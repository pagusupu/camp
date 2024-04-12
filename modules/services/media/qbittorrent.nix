{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = ["${inputs.qbit}/nixos/modules/services/torrent/qbittorrent.nix"];
  # awaiting pr
  options.cute.services.media.qbittorrent = lib.mkEnableOption "";
  config = let
    inherit (config.networking) domain;
  in
    lib.mkIf config.cute.services.media.qbittorrent {
      services = {
        qbittorrent = {
          enable = true;
          openFirewall = true;
          webuiPort = 8077;
          torrentingPort = 43862;
          profileDir = "/storage/services/qbit/profile";
          package = pkgs.qbittorrent-nox.overrideAttrs {meta.mainProgram = "qbittorrent-nox";};
          serverConfig = {
            LegalNotice.Accepted = true;
            BitTorrent.Session = {
              DefaultSavePath = "/storage/services/qbit/torrents";
              TorrentExportDirectory = "/storage/services/qbit/torrents/sources/";
              TempPath = "/storage/services/qbit/torrents/incomplete/";
              TempPathEnabled = true;
              QueueingSystemEnabled = true;
              IgnoreSlowTorrentsForQueueing = true;
              SlowTorrentsDownloadRate = 40;
              SlowTorrentsUploadRate = 40;
              GlobalDLSpeedLimit = 4000;
              GlobalUPSpeedLimit = 4000;
              GlobalMaxRatio = 2;
              MaxActiveCheckingTorrents = 2;
              MaxActiveDownloads = 3;
              MaxActiveUploads = 300;
              MaxActiveTorrents = 305;
              MaxUploads = 300;
              MaxConnections = 600;
            };
            Preferences = {
              WebUI = let
                vue = pkgs.fetchzip {
                  url = "https://github.com/VueTorrent/VueTorrent/releases/download/v2.7.2/vuetorrent.zip";
                  hash = "sha256-ys9CrbpOPYu8xJsCnqYKyC4IFD/SSAF8j+T+USqvGA8=";
                };
              in {
                AlternativeUIEnabled = true;
                RootFolder = vue;
                Username = "pagu";
                Password_PBKDF2 = ''"@ByteArray(kZipcTwDuigp5wDRkynNQA==:roLYJRl9n/jcGRTXzgont6GAsBm7Bu7LGfrUfB7QcQqgQRSOLNvBs9YrC6h8nMgN/4e4dDETmAQGF16S+zBD5Q==)"'';
                ReverseProxySupportEnabled = true;
                TrustedReverseProxiesList = "qbit.${domain}";
              };
              General.Locale = "en";
            };
          };
        };
        nginx.virtualHosts."qbit.${domain}" = {
          forceSSL = true;
          enableACME = true;
          locations."/".proxyPass = "http://0.0.0.0:8077";
        };
      };
    };
}
