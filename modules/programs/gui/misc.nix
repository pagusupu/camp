{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.programs.gui.misc = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.gui.misc (lib.mkMerge [
    {
      programs.localsend = {
        enable = true;
        openFirewall = true;
      };
      environment.systemPackages = with pkgs; [
        audacity
        easyeffects
        feishin
        heroic
        tailscale
        vesktop
      ];
    }
    {
      environment = {
        etc = {
          "jdks/21".source = lib.getBin pkgs.openjdk21;
          "jdks/17".source = lib.getBin pkgs.openjdk17;
          "jdks/8".source = lib.getBin pkgs.openjdk8;
        };
        systemPackages = [pkgs.prismlauncher];
      };
    }
  ]);
}
