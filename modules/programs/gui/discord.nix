{
  config,
  lib,
  cutelib,
  inputs,
  pkgs,
  ...
}: {
  options.cute.programs.gui.discord = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.gui.discord {
    home-manager.users.pagu = {
      imports = [inputs.nixcord.homeManagerModules.nixcord];
      programs.nixcord = {
        enable = true;
        discord.package = pkgs.discord.override {withTTS = false;};
        config = {
          plugins = {
            alwaysTrust = {
              enable = true;
              file = true;
            };
            betterSettings = {
              enable = true;
              disableFade = false;
            };
            newGuildSettings = {
              enable = true;
              messages = "only@Mentions";
              everyone = false;
              role = false;
            };
            alwaysAnimate.enable = true;
            betterUploadButton.enable = true;
            clearURLs.enable = true;
            disableCallIdle.enable = true;
            fixSpotifyEmbeds.enable = true;
            fixYoutubeEmbeds.enable = true;
            noF1.enable = true;
            noMosaic.enable = true;
            noProfileThemes.enable = true;
            onePingPerDM.enable = true;
            stickerPaste.enable = true;
            voiceChatDoubleClick.enable = true;
            youtubeAdblock.enable = true;
          };
          themeLinks = ["https://github.com/rose-pine/discord/raw/refs/heads/main/rose-pine-moon.theme.css"];
        };
        extraConfig = {
          openasar = {
            setup = true;
            quickstart = true;
          };
          MINIMIZE_TO_TRAY = false;
          OPEN_ON_STARTUP = false;
          SKIP_HOST_UPDATE = true;
        };
      };
    };
  };
}
