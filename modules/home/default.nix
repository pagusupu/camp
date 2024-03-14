{
  config,
  lib,
  inputs,
  rose-pine,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  options.cute.home = {
    enable = lib.mkEnableOption "";
    ags = lib.mkEnableOption "";
    mako = lib.mkEnableOption "";
    wofi = lib.mkEnableOption "";
    themes = {
      discord = lib.mkEnableOption "";
      firefox = lib.mkEnableOption "";
      woficss = lib.mkEnableOption "";
    };
  };
  config = let
    inherit (config.cute.home) enable ags mako wofi;
    inherit (config.cute.home.themes) discord firefox woficss;
  in {
    home-manager = lib.mkIf enable {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs;};
      users.pagu = {
        home = {
          username = "pagu";
          homeDirectory = "/home/pagu";
          stateVersion = "23.05";
          file = {
            "discord" = lib.mkIf discord {
              source = ./css/discord.css;
              target = ".config/vesktop/themes/rose-pine.theme.css";
            };
            "firefox" = lib.mkIf firefox {
              source = ./css/firefox.css;
              target = ".mozilla/firefox/pagu/chrome/userChrome.css";
            };
            "wofi" = lib.mkIf woficss {
              source = ./css/wofi.css;
              target = ".config/wofi/style.css";
            };
          };
        };
        imports = [inputs.ags.homeManagerModules.default];
        programs = {
          ags = lib.mkIf ags {
            enable = true;
            #extraPackages = with pkgs; [];
          };
          wofi = lib.mkIf wofi {
            enable = true;
            settings = {
              hide_scroll = true;
              insensitive = true;
              width = "10%";
              prompt = "";
              lines = 7;
            };
          };
        };
        services = let
          inherit (rose-pine) moon;
        in {
          mako = lib.mkIf mako {
            enable = true;
            anchor = "bottom-left";
            defaultTimeout = 3;
            maxVisible = 3;
            borderSize = 2;
            borderRadius = 6;
            margin = "14";
            backgroundColor = "#" + moon.overlay;
            borderColor = "#" + moon.iris;
            textColor = "#" + moon.text;
            extraConfig = ''
              [mode=do-not-disturb]
              invisible=1
            '';
          };
        };
      };
    };
    _module.args.images = {
      bg = images/bg.jpg;
      lock = images/lockbg.png;
    };
  };
}
