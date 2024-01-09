{lib, ...}: {
  options.cute.colours = lib.mkOption {};
  config.cute.colours = {
    primary = {
      bg = "191724";
      fg = "e0def4";
      main = "c4a7e7";
    };
    normal = {
      black = "26233a";
      red = "eb6f92";
      green = "31748f";
      yellow = "f6c177";
      blue = "9ccfd8";
      magenta = "c4a7e7";
      cyan = "ebbcba";
      orange = "ebbcba";
      white = "e0def4";
    };
    bright = {
      black = "6e6a86";
      red = "eb6f92";
      green = "31748f";
      yellow = "f6c177";
      blue = "9ccfd8";
      magenta = "c4a7e7";
      cyan = "ebbcba";
      orange = "ebbcba";
      white = "e0def4";
    };
  };
}
