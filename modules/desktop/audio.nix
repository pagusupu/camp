{
  config,
  lib,
  cutelib,
  inputs,
  ...
}: {
  imports = [ inputs.nix-gaming.nixosModules.pipewireLowLatency ];
  options.cute.desktop.audio = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.audio {
    services.pipewire = {
      enable = true;
      lowLatency = {
        enable = lib.mkIf config.networking.hostName == "rin";
        quantum = 48;
        rate = 48000;
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
