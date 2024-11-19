{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.programs.cli.starship = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.cli.starship {
    programs.starship = {
      enable = true;
      settings = let
        inherit (config.wh.colours) overlay;
      in {
        format = ''
          [$username[@](bg:${overlay} cyan)$hostname $directory $git_branch$fill $time]($style)
          $character
        '';
        character = {
          error_symbol = "[󰴈 ~>](red)";
          success_symbol = "[󰴈 ~>](purple)";
        };
        directory = {
          format = "[](dimmed black)[ $path ]($style)[](dimmed black)";
          read_only = " ";
          style = "bg:${overlay} green";
          truncation_length = 3;
          truncation_symbol = "../";
        };
        fill = {
          style = "dimmed black";
          symbol = " ";
        };
        git_branch = {
          format = "[](dimmed black)[ $symbol $branch ]($style)[](dimmed black)";
          style = "bg:${overlay} purple";
          symbol = "";
        };
        hostname = {
          format = "[$hostname ](bg:${overlay} yellow)[](dimmed black)[$ssh_symbol]($style)";
          ssh_symbol = " [](dimmed black)[  ](bg:${overlay} red)[](dimmed black)";
          style = "";
          ssh_only = false;
        };
        time = {
          disabled = false;
          format = "[](dimmed black)[ $time ]($style)[](dimmed black)";
          style = "bg:${overlay} cyan";
          time_format = "%I:%M%P";
          use_12hr = true;
        };
        username = {
          format = "[](dimmed black)[ $user]($style)";
          style_root = "bg:${overlay} red";
          style_user = "bg:${overlay} yellow";
          show_always = true;
        };
        add_newline = false;
      };
    };
  };
}
