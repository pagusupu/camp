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
        format = ''
          [$username[@](bold cyan)$hostname$directory$git_branch$git_status]($style)
          $character
        '';
        character = {
          error_symbol = "[󰋕 ~>](bold red)";
          success_symbol = "[󰋕 ~>](bold purple)";
        };
        directory = {
          read_only = " ";
          style = "bold green";
        };
        hostname = {
          format = "[$hostname](bold yellow) [$ssh_symbol](bold red)";
          ssh_symbol = "! ";
          ssh_only = false;
        };
        username = {
          format = "[$user]($style)";
          show_always = true;
        };
        git_status.deleted = "x";
      };
    };
  };
}
