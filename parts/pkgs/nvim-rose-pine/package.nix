{pkgs}:
pkgs.vimPlugins.rose-pine.overrideAttrs (_prev: {
  pname = "nvim-rose-pine";
  patches = [ ./notify-fix.patch ];
})
