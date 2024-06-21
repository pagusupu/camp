let
  server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExuEEnRUnoo1qZVnvLUtvXqCcBd7DcDJkohVCg0Qbij";
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIcZJ0IEzuvGNglNevP/pSpHNYd+iJwrpRO2yK8mg4lt";
in {
  "linkding.age".publicKeys = [server];
  "nextcloud.age".publicKeys = [server];
  "synapse.age".publicKeys = [server];
  "user.age".publicKeys = [desktop server];
}
