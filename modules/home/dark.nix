{
  config,
  lib,
  ...
}: {
  specialisation.dark.configuration = let
    inherit (config.cute.home) base16 gtk;
    inherit (config.cute.common) nixvim;
  in {
    home-manager.users.pagu = lib.mkIf gtk {
      gtk = {
        theme.name = "rose-pine-moon";
        iconTheme.name = "rose-pine-moon";
      };
      home.pointerCursor.name = "BreezeX-RosePineDawn-Linux";
    };
    scheme = lib.mkIf base16 rose-pine/moon.yaml;
    programs.nixvim.colorschemes.rose-pine.style = lib.mkIf nixvim "moon";
  };
}
