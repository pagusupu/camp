{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types mkMerge mkIf;
  inherit (types) str;
in {
  imports = [inputs.agenix.nixosModules.default];
  options.cute.enabled = let
    c = {
      type = types.bool;
      default = true;
    };
  in {
    git = mkOption {} // c;
    misc = mkOption {} // c;
    nix = mkOption {} // c;
    user = mkOption {} // c;
    net = {
      enable = mkOption {} // c;
      interface = mkOption {type = str;};
      ip = mkOption {type = str;};
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
        boot.enableContainers = false;
        i18n.defaultLocale = "en_NZ.UTF-8";
        time.timeZone = "NZ";
        xdg.sounds.enable = false;
        documentation = {
          enable = false;
          doc.enable = false;
          info.enable = false;
          nixos.enable = false;
        };
        hardware = {
          enableRedistributableFirmware = true;
          opengl.enable = true;
        };
        programs = {
          bash.enableCompletion = false;
          command-not-found.enable = false;
          nano.enable = false;
        };
        environment = {
          #defaultPackages = [];
          variables = let
            d = "/home/pagu/";
          in {
            XDG_DATA_HOME = d + ".local/share";
            XDG_CONFIG_HOME = d + ".config";
            XDG_STATE_HOME = d + ".local/state";
            XDG_CACHE_HOME = d + ".cache";
          };
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
          isNormalUser = true;
          extraGroups = ["wheel"];
          uid = 1000;
          hashedPasswordFile = config.age.secrets.user.path;
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
            auto-optimise-store = true;
            builders-use-substitutes = true;
            use-xdg-base-directories = true;
            warn-dirty = false;
            allowed-users = ["@wheel"];
            nix-path = ["nixpkgs=flake:nixpkgs"];
          };
          channel.enable = false;
          optimise.automatic = true;
          nixPath = ["nixpkgs=/etc/nix/inputs/nixpkgs"];
        };
        nixpkgs = {
          config.allowUnfree = true;
          hostPlatform = "x86_64-linux";
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
