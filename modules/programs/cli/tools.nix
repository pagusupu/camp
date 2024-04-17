{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.programs.cli = {
    ssh = mkEnableOption "";
    btop = mkEnableOption "";
    yazi = mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs.cli) ssh btop yazi;
  in
    mkMerge [
      (mkIf ssh {
        services.openssh = {
          enable = true;
          settings = {
            PermitRootLogin = "no";
            PasswordAuthentication = false;
          };
        };
        users.users.pagu.openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGwCFQYJB+4nhIqktQwJemynSOEP/sobnV2vESSY3tk" # desktop nixos
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIqJoNQ+5r3whthoNHP3C++gI/KE6iMgrD81K6xDQ//V" # desktop windows
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqzdZDv69pd3yQEIiq79vRKrDE5PlxINJFhpDvpE/vR" # laptop
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyA6gv1M1oeN8CnDLR3Z3VdcgK3hbRhHB3Nk6VbWwjK" # phone
        ];
      })
      (mkIf btop {
        home.file."btop" = {
          target = ".config/btop/btop.conf";
          source = (pkgs.formats.toml {}).generate "btop.conf" {
            color_theme = "TTY";
            theme_background = false;
            proc_sorting = "name";
            proc_tree = true;
            proc_left = true;
            proc_filter_kernel = true;
            show_swap = false;
            show_io_stat = false;
            show_battery = false;
            net_iface = "${config.cute.enabled.net.interface}";
          };
        };
        environment.systemPackages = [pkgs.btop];
      })
      (mkIf yazi {
        home.file."yazi" = {
          target = ".config/yazi/yazi.toml";
          source = (pkgs.formats.toml {}).generate "yazi.toml" {
            manager = {
              sort_by = "natural";
              sort_dir_first = true;
            };
          };
        };
        environment.systemPackages = [pkgs.yazi];
      })
    ];
}
