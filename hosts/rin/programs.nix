{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    audacity
    easyeffects
    heroic
    keyguard
    radeontop
    sublime-music
    xfce.thunar
  ];
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
}
