{...}: {
  programs.dconf.enable = true;
  home-manager.users.pagu.qt = {
    enable = true;
    platformTheme = "gtk";
  };
}
