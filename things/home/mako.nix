{
  config,
  lib,
  ...
}: {
  options.local.programs.mako = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.local.programs.mako.enable {
    home.file.".config/mako/config".text = ''
      layer=overlay
      max-icon-size=64
      default-timeout=5000
      ignore-timeout=1
      max-visible=2
      font=nunito 14
      anchor=top-center
      width=300
      height=110
      background-color=#191919
      text-color=#a0a0a0
      border-size=2
      border-color=#ac8a8c
      border-radius=7
    '';
  };
}

        
