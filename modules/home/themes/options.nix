{lib, ...}: {
  options.cute.themes = {
    rose-pine = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
}
