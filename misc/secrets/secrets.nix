let
  aoi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExuEEnRUnoo1qZVnvLUtvXqCcBd7DcDJkohVCg0Qbij";
  rin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIcZJ0IEzuvGNglNevP/pSpHNYd+iJwrpRO2yK8mg4lt";
in {
  "linkding.age".publicKeys = [aoi];
  "nextcloud.age".publicKeys = [aoi];
  "synapse.age".publicKeys = [aoi];
  "user.age".publicKeys = [aoi rin];
}
