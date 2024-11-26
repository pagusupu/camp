{pkgs}:
pkgs.vimPlugins.rose-pine.overrideAttrs (_prev: {
  pname = "nvim-rose-pine";
  version = "unstable-2024-10-23";
  patches = [ ./notify-fix.patch ];
})
