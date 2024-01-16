{
  config,
  lib,
  ...
}: {
  options.cute.desktop.misc.audio.enable = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.misc.audio.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      lowLatency = {
        enable = true;
        quantum = 96;
        rate = 96000;
      };
    };
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
  };
}
