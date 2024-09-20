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
        palettes.rose-pine = with config.colours; {
          overlay = "#" + overlay;
          love = "#" + love;
          gold = "#" + gold;
          rose = "#" + rose;
          pine = "#" + pine;
          foam = "#" + foam;
          iris = "#" + iris;
        };
        palette = "rose-pine";
        format = ''
          [$username[@](bg:overlay fg:rose)$hostname $directory $git_branch$fill $time]($style)
          $character
        '';
        character = {
          error_symbol = "[󰴈 ~>](fg:love)";
          success_symbol = "[󰴈 ~>](fg:iris)";
        };
        directory = {
          format = "[](fg:overlay)[ $path ]($style)[](fg:overlay)";
          read_only = " ";
          style = "bg:overlay fg:pine";
          truncation_length = 3;
          truncation_symbol = ".../";
        };
        fill = {
          style = "fg:overlay";
          symbol = " ";
        };
        git_branch = {
          format = "[](fg:overlay)[ $symbol $branch ]($style)[](fg:overlay)";
          style = "bg:overlay fg:iris";
          symbol = "";
        };
        hostname = {
          format = "[$hostname ](bg:overlay fg:gold)[](fg:overlay)[$ssh_symbol]($style)";
          ssh_symbol = " [](fg:overlay)[  ](bg:overlay fg:love)[](fg:overlay)";
          style = "";
          ssh_only = false;
        };
        time = {
          disabled = false;
          format = "[](fg:overlay)[ $time ]($style)[](fg:overlay)";
          style = "bg:overlay fg:rose";
          time_format = "%I:%M%P";
          use_12hr = true;
        };
        username = {
          format = "[](fg:overlay)[ $user](bg:overlay fg:gold)";
          show_always = true;
        };
        add_newline = false;
      };
    };
  };
}
