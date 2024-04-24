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
        format = "$hostname\$directory\$git_branch\$git_status\$cmd_duration\$line_break\$character";
        character = {
          error_symbol = "[](bold red)";
          success_symbol = "[](bold green)";
          vimcmd_symbol = "[](bold green)";
          vimcmd_replace_one_symbol = "[](bold orange)";
          vimcmd_replace_symbol = "[](bold orange)";
          vimcmd_visual_symbol = "[](bold yellow)";
        };
        directory = {
          home_symbol = " ";
          read_only = " ";
          style = "bold purple";
          truncation_length = 5;
        };
        hostname = {
          format = "[$hostname](bold purple) | ";
          ssh_only = false;
        };
        git_status.deleted = "x";
      };
    };
  };
}
