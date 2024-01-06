{lib, ...}: {
  options.cute.colours = lib.mkOption {};
  config.cute.colours = {
    #https://github.com/mountain-theme/Mountain
    primary = {
      bg = "0f0f0f";
      fg = "f0f0f0";
      main = "8aac8b";
    };
    normal = {
      black = "262626";
      red = "ac8a8c";
      green = "8aac8b";
      yellow = "aca98a";
      blue = "8a98ac";
      magenta = "ac8aac";
      cyan = "8aacab";
      orange = "c6a679";
      white = "e7e7e7";
    };
    bright = {
      black = "4c4c4c";
      red = "c49ea0";
      green = "9ec49f";
      yellow = "c4c19e";
      blue = "a5b4cb";
      magenta = "c49ec4";
      cyan = "9ec3c4";
      orange = "ceb188";
      white = "f0f0f0";
    };
  };
}
