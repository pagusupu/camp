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
    assertions = cutelib.assertHm "nixcord";
    home-manager.users.pagu = {
      programs.nixcord = {
        enable = false;
        vesktop = {
          enable = true;
          package = pkgs.vesktop.override { withTTS = false; };
        };
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
            betterSettings.enable = true;
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
          themeLinks = [ "https://raw.githubusercontent.com/rose-pine/discord/refs/heads/main/rose-pine.theme.css" ];
        };
        discord.enable = false;
        extraConfig.SKIP_HOST_UPDATE = true;
      };
      imports = [ inputs.nixcord.homeManagerModules.nixcord ];
    };
  };
}
