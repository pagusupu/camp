let
  aoi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExuEEnRUnoo1qZVnvLUtvXqCcBd7DcDJkohVCg0Qbij";
  rin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIcZJ0IEzuvGNglNevP/pSpHNYd+iJwrpRO2yK8mg4lt";
in {
  "etebase.age".publicKeys = [aoi];
  "freshrss.age".publicKeys = [aoi];
  "nextcloud.age".publicKeys = [aoi];
  "tailscale.age".publicKeys = [aoi rin];
  "user.age".publicKeys = [aoi rin];
}
