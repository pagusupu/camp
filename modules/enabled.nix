{
  config,
  lib,
  _lib,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types mkMerge mkIf;
  inherit (_lib) mkEnabledOption;
  inherit (types) str;
in {
  imports = [inputs.agenix.nixosModules.default];
  options.cute = {
    enabled = {
      git = mkEnabledOption;
      misc = mkEnabledOption;
      nix = mkEnabledOption;
      ssh = mkEnabledOption;
      user = mkEnabledOption;
    };
    net = {
      enable = mkEnabledOption;
      name = mkOption {type = str;};
      ip = mkOption {type = str;};
    };
  };
  config = let
    inherit (config.cute.enabled) git misc nix ssh user;
  in
    mkMerge [
      (mkIf git {
        programs.git = {
          enable = true;
          config = {
            github.user = "pagusupu";
            init.defaultBranch = "main";
            user = {
              email = "me@pagu.cafe";
              name = "pagu";
              signingKey = "/home/pagu/.ssh/id_ed25519.pub";
            };
            commit.gpgsign = true;
            gpg.format = "ssh";
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
          graphics.enable = true;
        };
        programs = {
          bash.completion.enable = false;
          command-not-found.enable = false;
          nano.enable = false;
        };
        environment.variables = let
          d = "/home/pagu/";
        in {
          XDG_CACHE_HOME = d + ".cache";
          XDG_CONFIG_HOME = d + ".config";
          XDG_DATA_HOME = d + ".local/share";
          XDG_STATE_HOME = d + ".local/state";
        };
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
            builders-use-substitutes = true;
            nix-path = ["nixpkgs=flake:nixpkgs"];
            trusted-users = ["pagu"];
            use-xdg-base-directories = true;
            warn-dirty = false;
          };
          channel.enable = false;
          nixPath = ["nixpkgs=/etc/nix/inputs/nixpkgs"];
          optimise.automatic = true;
          registry.nixpkgs.flake = inputs.nixpkgs;
        };
        nixpkgs = {
          config.allowUnfree = true;
          hostPlatform = "x86_64-linux";
        };
        environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
      })
      (mkIf ssh {
        services.openssh = {
          enable = true;
          knownHosts = {
            aoi = mkIf (config.networking.hostName != "aoi") {
              extraHostNames = ["192.168.178.182"];
              publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExuEEnRUnoo1qZVnvLUtvXqCcBd7DcDJkohVCg0Qbij";
            };
            "github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
          };
          hostKeys = [
            {
              comment = "${config.networking.hostName} host";
              path = "/etc/ssh/${config.networking.hostName}_ed25519_key";
              type = "ed25519";
            }
          ];
        };
      })
      (mkIf user {
        environment.systemPackages = [inputs.agenix.packages.${pkgs.system}.default];
        age = {
          secrets.user = {
            file = ../misc/secrets/user.age;
            owner = "pagu";
          };
          identityPaths = ["/etc/ssh/${config.networking.hostName}_ed25519_key"];
        };
        users.users.pagu = {
          isNormalUser = true;
          extraGroups = ["wheel"];
          uid = 1000;
          hashedPasswordFile = config.age.secrets.user.path;
        };
        security.sudo.execWheelOnly = true;
      })
      (
        let
          inherit (config.cute.net) enable name ip;
        in
          mkIf enable {
            networking = {
              enableIPv6 = false;
              useDHCP = false;
            };
            systemd.network = {
              enable = true;
              networks.${name} = {
                inherit enable name;
                networkConfig = {
                  DHCP = "no";
                  DNSSEC = "yes";
                  DNSOverTLS = "yes";
                  DNS = ["1.0.0.1" "1.1.1.1"];
                };
                address = ["${ip}/24"];
                routes = [{Gateway = "192.168.178.1";}];
              };
            };
          }
      )
    ];
}
