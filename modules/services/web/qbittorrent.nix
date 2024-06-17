{
  config,
  lib,
  _lib,
  pkgs,
  inputs,
  ...
}: {
  imports = ["${inputs.qbit}/nixos/modules/services/torrent/qbittorrent.nix"];
  options.cute.services.web.qbittorrent = _lib.mkWebOpt "qbit" 8077;
  config = let
    inherit (config.cute.services.web.qbittorrent) enable port dns;
    inherit (config.networking) domain;
  in
    lib.mkIf enable {
      assertions = _lib.assertNginx;
      services.qbittorrent = {
        inherit enable;
        openFirewall = true;
        webuiPort = port;
        torrentingPort = 43862;
        package = inputs.qbit.legacyPackages.${pkgs.system}.qbittorrent-nox;
        serverConfig = {
          LegalNotice.Accepted = true;
          BitTorrent.Session = let
            basePath = "/storage/services/qbit/torrents/";
          in {
            DefaultSavePath = basePath + "misc/";
            TorrentExportDirectory = basePath + "sources/";
            TempPath = basePath + "incomplete/";
            TempPathEnabled = true;
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
              #AlternativeUIEnabled = true;
              #RootFolder = pkgs.fetchzip {
              #  url = "https://github.com/VueTorrent/VueTorrent/releases/download/v2.8.0/vuetorrent.zip";
              #  hash = "sha256-ewk4P88Nyd9dzsBJ/7jHaFSipbEOuSnj2Bpesl5+itc=";
              #};
              Username = "pagu";
              Password_PBKDF2 = ''"@ByteArray(kZipcTwDuigp5wDRkynNQA==:roLYJRl9n/jcGRTXzgont6GAsBm7Bu7LGfrUfB7QcQqgQRSOLNvBs9YrC6h8nMgN/4e4dDETmAQGF16S+zBD5Q==)"'';
              ReverseProxySupportEnabled = true;
              TrustedReverseProxiesList = "${dns}.${domain}";
            };
            General.Locale = "en";
          };
        };
      };
    };
}
