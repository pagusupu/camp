{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = ["${inputs.qbit}/nixos/modules/services/torrent/qbittorrent.nix"];
  # awaiting pr
  options.cute.services.qbit = lib.mkEnableOption "";
  config = let
    domain = "qbit.${config.cute.services.nginx.domain}";
  in
    lib.mkIf config.cute.services.qbit {
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
              SlowTorrentsDownloadRate = 50;
              SlowTorrentsUploadRate = 50;
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
              WebUI = {
                AlternativeUIEnabled = true;
                RootFolder = pkgs.fetchFromGitHub {
                  owner = "VueTorrent";
                  repo = "VueTorrent";
                  rev = "v2.7.1";
                  hash = "sha256-ZkeDhXDBjakTmJYN9LZtSRMSkaySt1MhS9QDEujBdYI=";
                };
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
          locations."/".proxyPass = "http://0.0.0.0:8077";
        };
      };
    };
}
