{
  mcolours,
  pkgs,
  ...
}: {
  imports = [./colours.nix];
  console = {
    earlySetup = true;
    keyMap = "us";
    colors = [
      "000000"
      mcolours.normal.red
      mcolours.normal.green
      mcolours.normal.yellow
      mcolours.normal.blue
      mcolours.normal.magenta
      mcolours.normal.cyan
      mcolours.normal.white
      mcolours.bright.red
      mcolours.bright.green
      mcolours.bright.yellow
      mcolours.bright.blue
      mcolours.bright.magenta
      mcolours.bright.cyan
      mcolours.bright.white
      mcolours.primary.fg
    ];
  };
}
