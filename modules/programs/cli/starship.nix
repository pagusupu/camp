{
  config,
  lib,
  ...
}: {
  options.cute.programs.cli.starship = lib.mkEnableOption "";
  config = lib.mkIf config.cute.programs.cli.starship {
    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[](bold green)";
          error_symbol = "[](bold red)";
        };
        directory = {
          home_symbol = " ";
          read_only = " ";
          style = "bold purple";
          truncation_length = 5;
        };
        git_status.deleted = "x";
        hostname.format = "[$hostname]($style) in ";
      };
    };
  };
}
