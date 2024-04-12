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
        format = "$hostname\$directory\$git_branch\$git_status\$nix_shell\$cmd_duration\$line_break\$character";
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
        hostname = {
          format = "[$hostname\$ssh_symbol]($style) | ";
          ssh_only = false;
          ssh_symbol = "";
        };
        git_status.deleted = "x";
      };
    };
  };
}
