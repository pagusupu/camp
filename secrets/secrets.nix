let
  aoi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExuEEnRUnoo1qZVnvLUtvXqCcBd7DcDJkohVCg0Qbij";
  ena = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDM4qA5VHz8pRZMmEZk06ber5mm3apBexIwkc5pIlQvE";
  rin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIcZJ0IEzuvGNglNevP/pSpHNYd+iJwrpRO2yK8mg4lt";
in {
  "etebase.age".publicKeys = [aoi];
  "freshrss.age".publicKeys = [aoi];
  "tailscale.age".publicKeys = [aoi ena rin];
  "user.age".publicKeys = [aoi ena rin];
}
