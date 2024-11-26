# thanks NotAShelf
# https://github.com/NotAShelf/nyxexprs/tree/main/pkgs/alejandra-custom
{pkgs, ...}:
pkgs.alejandra.overrideAttrs (_prev: {
  pname = "alejandra-custom";
  version = "unstable-2024-07-21";
  patches = [ ./spaced-elements.patch ];
  meta.mainProgram = "alejandra";
})
