{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.desktop.xdg = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.xdg {
    assertions = cutelib.assertHm "xdg";
    home-manager.users.pagu = {
      xdg = {
        enable = true;
        desktopEntries =
          lib.genAttrs [
            "Alacritty"
            "btop"
            "fish"
            "thunar-bulk-rename"
            "thunar-settings"
            "yazi"
          ]
          (n: {
            name = n;
            noDisplay = true;
          });
        mimeApps = {
          enable = true;
          defaultApplications = let
            browser = ["floorp.desktop"];
          in {
            "application/x-extension-htm" = browser;
            "application/x-extension-html" = browser;
            "application/x-extension-shtml" = browser;
            "application/x-extension-xht" = browser;
            "application/x-extension-xhtml" = browser;
            "application/xhtml+xml" = browser;
            "text/html" = browser;
            "x-scheme-handler/about" = browser;
            "x-scheme-handler/ftp" = browser;
            "x-scheme-handler/http" = browser;
            "x-scheme-handler/https" = browser;
            "x-scheme-handler/unknown" = browser;
            "application/pdf" = ["okularApplication_pdf.desktop"];
            "inode/directory" = ["thunar.desktop"];
          };
        };
        userDirs = let
          p = "/home/pagu/";
        in {
          enable = true;
          desktop = p + ".desktop";
          documents = p + "documents";
          download = p + "downloads";
          pictures = p + "pictures";
          videos = p + "pictures/videos";
          extraConfig.XDG_SCREENSHOT_DIR = p + "pictures/screenshots";
        };
      };
      home.preferXdgDirectories = true;
    };
  };
}
