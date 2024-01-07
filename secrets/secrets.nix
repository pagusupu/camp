let
  server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKj709k07PEtMHhT9Leb1pVkS2kduiyogmyXqNmLRgfp";
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGwCFQYJB+4nhIqktQwJemynSOEP/sobnV2vESSY3tk";
in {
  "nextcloud.age".publicKeys = [server];
  "home-assistant.age".publicKeys = [server];
  "mail.age".publicKeys = [server];
  "user.age".publicKeys = [desktop server];
}
