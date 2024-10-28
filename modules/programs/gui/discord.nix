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
      programs.nixcord = {
        enable = true;
        config = {
          plugins = {
            alwaysTrust = {
              enable = true;
              file = true;
            };
            anonymiseFileNames = {
              enable = true;
              anonymiseByDefault = true;
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
            favoriteEmojiFirst.enable = true;
            favoriteGifSearch.enable = true;
            fixSpotifyEmbeds.enable = true;
            fixYoutubeEmbeds.enable = true;
            noF1.enable = true;
            noMosaic.enable = true;
            noOnboardingDelay.enable = true;
            noProfileThemes.enable = true;
            noRPC.enable = true;
            onePingPerDM.enable = true;
            plainFolderIcon.enable = true;
            stickerPaste.enable = true;
            voiceChatDoubleClick.enable = true;
            youtubeAdblock.enable = true;
          };
          themeLinks = ["https://github.com/rose-pine/discord/raw/refs/heads/main/rose-pine-moon.theme.css"];
        };
        discord.package = pkgs.discord.override {withTTS = false;};
      };
      imports = [inputs.nixcord.homeManagerModules.nixcord];
    };
  };
}
