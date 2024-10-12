{
  config,
  lib,
  cutelib,
  inputs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  options.cute.desktop.home-manager = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.home-manager (lib.mkMerge [
    {
      home-manager = {
        users.pagu.home = {
          username = "pagu";
          homeDirectory = "/home/pagu";
          stateVersion = "23.05";
        };
        extraSpecialArgs = {inherit inputs;};
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    }
    {
      home-manager.users.pagu = {
        xdg = {
          enable = true;
          mimeApps = {
            enable = true;
            defaultApplications = let
              browser = ["firefox.desktop"];
            in {
              "application/json" = browser;
              "application/pdf" = browser;
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
    }
  ]);
}
