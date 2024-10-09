{
  lib,
  pkgs,
  ...
}: {
  environment = lib.mkMerge [
    {
      systemPackages = with pkgs; [
        audacity
        easyeffects
        heroic
        keyguard
        radeontop
        sublime-music
      ];
    }
    {
      etc = {
        "jdks/21".source = lib.getBin pkgs.openjdk21;
        "jdks/17".source = lib.getBin pkgs.openjdk17;
        "jdks/8".source = lib.getBin pkgs.openjdk8;
      };
      systemPackages = [pkgs.prismlauncher];
    }
  ];
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
}
