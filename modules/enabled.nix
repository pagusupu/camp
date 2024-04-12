{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types mkMerge mkIf;
in {
  imports = [inputs.agenix.nixosModules.default];
  options.cute.enabled = let
    common = {
      type = types.bool;
      default = true;
    };
  in {
    git = mkOption {} // common;
    misc = mkOption {} // common;
    nix = mkOption {} // common;
    user = mkOption {} // common;
    net = {
      enable = mkOption {} // common;
      interface = mkOption {type = types.str;};
      ip = mkOption {type = types.str;};
    };
  };
  config = let
    inherit (config.cute.enabled) git misc net nix user;
  in
    mkMerge [
      (mkIf git {
        programs.git = {
          enable = true;
          config = {
            init.defaultBranch = "main";
            user = {
              name = "pagu";
              email = "me@pagu.cafe";
              signingKey = "/home/pagu/.ssh/id_ed25519.pub";
            };
            gpg.format = "ssh";
            commit.gpgsign = true;
          };
        };
      })
      (mkIf misc {
        time.timeZone = "NZ";
        i18n.defaultLocale = "en_NZ.UTF-8";
        hardware = {
          enableRedistributableFirmware = true;
          opengl.enable = true;
        };
      })
      (mkIf user {
        environment.systemPackages = [inputs.agenix.packages.${pkgs.system}.default];
        age = {
          identityPaths = ["/home/pagu/.ssh/id_ed25519"];
          secrets.user = {
            file = ../misc/secrets/user.age;
            owner = "pagu";
          };
        };
        users.users.pagu = {
          uid = 1000;
          isNormalUser = true;
          extraGroups = ["wheel"];
          hashedPasswordFile = config.age.secrets.user.path;
        };
        environment.variables = {
          XDG_DATA_HOME = "\$HOME/.local/share";
          XDG_CONFIG_HOME = "\$HOME/.config";
          XDG_STATE_HOME = "\$HOME/.local/state";
          XDG_CACHE_HOME = "\$HOME/.cache";
          XDG_DESKTOP_DIR = "\$HOME/desktop";
          XDG_DOCUMENTS_DIR = "\$HOME/documents";
          XDG_DOWNLOAD_DIR = "\$HOME/downloads";
          XDG_PICTURES_DIR = "\$HOME/pictures";
          XDG_VIDEOS_DIR = "\$HOME/pictures/videos";
        };
        security.sudo.execWheelOnly = true;
      })
      (mkIf nix {
        nix = {
          settings = {
            experimental-features = [
              "auto-allocate-uids"
              "flakes"
              "nix-command"
              "no-url-literals"
            ];
            allowed-users = ["@wheel"];
            auto-optimise-store = true;
            nix-path = ["nixpkgs=flake:nixpkgs"];
            use-xdg-base-directories = true;
            warn-dirty = false;
          };
          gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
          };
          channel.enable = false;
          nixPath = ["nixpkgs=/etc/nix/inputs/nixpkgs"];
          optimise.automatic = true;
        };
        nixpkgs = {
          hostPlatform = "x86_64-linux";
          config.allowUnfree = true;
        };
        documentation = {
          enable = false;
          doc.enable = false;
          info.enable = false;
          nixos.enable = false;
        };
      })
      (let
        inherit (net) enable interface ip;
      in
        mkIf enable {
          networking = {
            firewall.enable = true;
            enableIPv6 = false;
            useDHCP = false;
          };
          systemd.network = {
            enable = true;
            networks.${interface} = {
              name = interface;
              networkConfig = {
                DHCP = "no";
                DNSSEC = "yes";
                DNSOverTLS = "yes";
                DNS = ["1.0.0.1" "1.1.1.1"];
              };
              address = ["${ip}/24"];
              routes = [{routeConfig.Gateway = "192.168.178.1";}];
            };
          };
        })
    ];
}
