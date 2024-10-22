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
      extraConfig.pipewire."92-low-latency" = lib.mkIf (config.networking.hostName == "rin") {
        context.properties.default.clock = {
          max-quantum = 48;
          min-quantum = 48;
          quantum = 48;
          rate = 48000;
        };
      };
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
