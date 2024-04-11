{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.programs.cli = {
    ssh = lib.mkEnableOption "";
    yazi = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs.cli) ssh yazi;
    inherit (lib) mkMerge mkIf;
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
      (mkIf yazi {
        home.file."yazi" = {
          target = ".config/yazi/yazi.toml";
          source = (pkgs.formats.toml {}).generate "yazi.toml" {
            manager = {
              sort_by = "natrual";
              sort_dir_first = true;
            };
          };
        };
        environment.systemPackages = [pkgs.yazi];
      })
    ];
}
