{
  config,
  lib,
  _lib,
  inputs,
  ...
}: {
  imports = [inputs.nix-gaming.nixosModules.pipewireLowLatency];
  options.cute.desktop.misc.audio = _lib.mkEnable;
  config = lib.mkIf config.cute.desktop.misc.audio {
    services.pipewire = {
      enable = true;
      jack.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      lowLatency = lib.mkIf (config.networking.hostName == "rin") {
        enable = true;
        quantum = 48;
        rate = 96000;
      };
    };
    security.rtkit.enable = true;
    hardware.pulseaudio.enable = false;
  };
}
