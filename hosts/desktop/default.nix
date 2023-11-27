{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./user.nix
    ../../system
  ];
  cute = {
    misc = {
      console.enable = true;
      fonts.enable = true;
      nix.enable = true;
      shell.enable = true;
    };
    xserver = {
      desktop.enable = true;
      common = {
	lightdm.enable = true;
      };
    };
  };
  time = {
    timeZone = "NZ";
    hardwareClockInLocalTime = true;
  };
  i18n.defaultLocale = "en_NZ.UTF-8";
  programs = {
    command-not-found.enable = false;
    nano.enable = false;
    steam.enable = true;
  };
  services = {
    blueman.enable = true;
    dbus.enable = true;
    sshd.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    }; 
  };
  security = {
    rtkit.enable = true;
    tpm2.enable = true;
    sudo = {
      execWheelOnly = true;
      wheelNeedsPassword = false;
    };
  };
  environment = {
    defaultPackages = lib.mkForce [];
    systemPackages = with pkgs; [alejandra inputs.agenix.packages.x86_64-linux.default];
    sessionVariables = {FLAKE="/home/pagu/flake";};
  };
  system.stateVersion = "23.11";
}
