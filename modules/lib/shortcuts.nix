{...}: let
  ssl = {
    forceSSL = true;
    enableACME = true;
  };
in {
  options.cute.shortcuts = {
    ssl = ssl;
  };
}
