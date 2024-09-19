let
  aoi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKj709k07PEtMHhT9Leb1pVkS2kduiyogmyXqNmLRgfp";
  rin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGwCFQYJB+4nhIqktQwJemynSOEP/sobnV2vESSY3tk";
in {
  "nextcloud.age".publicKeys = [aoi];
  "tailscale.age".publicKeys = [aoi];
  "user.age".publicKeys = [aoi rin];
}
