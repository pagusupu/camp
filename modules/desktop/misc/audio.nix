{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.desktop.misc.audio = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.misc.audio {
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
    };
    security.rtkit.enable = true;
    hardware.pulseaudio.enable = false;
  };
}
