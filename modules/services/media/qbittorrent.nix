{
  config,
  lib,
  cutelib,
  pkgs,
  inputs,
  ...
}: {
  imports = ["${inputs.qbit}/nixos/modules/services/torrent/qbittorrent.nix"];
  options.cute.services.media.qbittorrent = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.media.qbittorrent {
    assertions = cutelib.assertNginx "qbittorrent";
    services = {
      qbittorrent = {
        enable = true;
        openFirewall = true;
        webuiPort = 8077;
        torrentingPort = 43862;
        package = inputs.qbit.legacyPackages.${pkgs.system}.qbittorrent-nox;
        serverConfig = lib.mkMerge [
          {
            LegalNotice.Accepted = true;
            BitTorrent.Session = {
              QueueingSystemEnabled = true;
              IgnoreSlowTorrentsForQueueing = true;
              SlowTorrentsDownloadRate = 40;
              SlowTorrentsUploadRate = 40;
              GlobalDLSpeedLimit = 4000;
              GlobalUPSpeedLimit = 4000;
              MaxActiveCheckingTorrents = 2;
              MaxActiveDownloads = 3;
              MaxActiveUploads = 300;
              MaxActiveTorrents = 305;
              MaxUploads = 300;
              MaxConnections = 600;
            };
            Preferences = {
              WebUI = {
                Username = "pagu";
                Password_PBKDF2 = ''"@ByteArray(kZipcTwDuigp5wDRkynNQA==:roLYJRl9n/jcGRTXzgont6GAsBm7Bu7LGfrUfB7QcQqgQRSOLNvBs9YrC6h8nMgN/4e4dDETmAQGF16S+zBD5Q==)"'';
                ReverseProxySupportEnabled = true;
                TrustedReverseProxiesList = "qbit.pagu.cafe";
              };
              General.Locale = "en";
            };
          }
          (let
            p = "/storage/services/qbit/torrents/";
          in {
            BitTorrent.Session = {
              DefaultSavePath = p + "misc/";
              TorrentExportDirectory = p + "sources/";
              TempPath = p + "incomplete/";
              TempPathEnabled = true;
            };
            Preferences.WebUI = {
              RootFolder = "${pkgs.fetchzip {
                url = "https://github.com/VueTorrent/VueTorrent/releases/download/v2.15.0/vuetorrent.zip";
                hash = "sha256-AWXlhiNEJAhEShCzJ42wGMJpL5beYlcUrrEPuJFv1k8=";
              }}";
              AlternativeUIEnabled = true;
            };
          })
        ];
      };
      nginx.virtualHosts."qbit.pagu.cafe" = {
        enableACME = true;
        forceSSL = true;
        locations."/".proxyPass = "http://localhost:8077";
      };
    };
  };
}
