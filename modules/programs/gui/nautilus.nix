{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.programs.gui.nautilus = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.gui.nautilus {
    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "alacritty";
    };
    environment = {
      pathsToLink = ["/share/nautilus-python/extensions"];
      sessionVariables.NAUTILUS_4_EXTENSION_DIR = "${pkgs.nautilus-python}/lib/nautilus/extensions-4";
    };
    home-manager.users.pagu = {
      home.packages = with pkgs; [
        nautilus
        nautilus-python
        #sushi
      ];
      xdg.mimeApps.defaultApplications."inode/directory" = lib.mkIf config.cute.desktop.xdg ["nautilus.desktop"];
    };
  };
}
