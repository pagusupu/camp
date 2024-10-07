{
  lib,
  pkgs,
  ...
}:
lib.mkMerge [
  {
    environment.systemPackages = with pkgs; [
      audacity
      easyeffects
      feishin
      heroic
      radeontop
    ];
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
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
]
