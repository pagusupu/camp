{lib, ...}: {
  options.cute.images = lib.mkOption {};
  config.cute.images = {
    bg = images/bg.jpg;
    lock = images/lockbg.png;
  };
}
