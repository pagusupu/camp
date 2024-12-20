# thanks NotAShelf
# https://github.com/NotAShelf/nyxexprs/tree/main/pkgs/alejandra-custom
{pkgs, ...}:
pkgs.alejandra.overrideAttrs (_prev: {
  pname = "alejandra-custom";
  patches = [ ./spaced-elements.patch ];
  meta.mainProgram = "alejandra";
})
