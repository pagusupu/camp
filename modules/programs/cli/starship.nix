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
      settings = {
        format = ''
          [$username[@](bg:bright-black cyan)$hostname $directory $git_branch$fill $time]($style)
          $character
        '';
        character = {
          error_symbol = "[󰴈 ~>](red)";
          success_symbol = "[󰴈 ~>](purple)";
        };
        directory = {
          format = "[](bright-black)[ $path ]($style)[](bright-black)";
          read_only = " ";
          style = "bg:bright-black green";
          truncation_length = 3;
          truncation_symbol = "../";
        };
        fill = {
          style = "bright-black";
          symbol = " ";
        };
        git_branch = {
          format = "[](bright-black)[ $symbol $branch ]($style)[](bright-black)";
          style = "bg:bright-black purple";
          symbol = "";
        };
        hostname = {
          format = "[$hostname ](bg:bright-black yellow)[](bright-black)[$ssh_symbol]($style)";
          ssh_symbol = " [](bright-black)[  ](bg:bright-black red)[](bright-black)";
          style = "";
          ssh_only = false;
        };
        time = {
          disabled = false;
          format = "[](bright-black)[ $time ]($style)[ ](bright-black)";
          style = "bg:bright-black cyan";
          time_format = "%I:%M%P";
          use_12hr = true;
        };
        username = {
          format = "[](bright-black)[ $user]($style)";
          style_root = "bg:bright-black red";
          style_user = "bg:bright-black yellow";
          show_always = true;
        };
        add_newline = false;
      };
    };
  };
}
