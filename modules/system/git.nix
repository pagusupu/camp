{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.system.git = cutelib.mkEnabledOption;
  config = lib.mkIf config.cute.system.git {
    programs.git = {
      enable = true;
      config = {
        github.user = "pagusupu";
        init.defaultBranch = "main";
        user = {
          email = "me@pagu.cafe";
          name = "pagu";
          signingKey = "/home/pagu/.ssh/id_ed25519.pub";
        };
        commit.gpgsign = true;
        gpg.format = "ssh";
      };
    };
  };
}
