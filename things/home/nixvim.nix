{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nixvim.homeManagerModules.nixvim];
  programs.nixvim = {
    enable = true;
    vimAlias = true;
    options = {
      number = true;
      title = true;
    };
  };
}
