let
  server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKj709k07PEtMHhT9Leb1pVkS2kduiyogmyXqNmLRgfp";
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM96wFExSY7APK/zcIs957BxI7Nt2AsBQx8enoJldv9q";
in {
  "nextcloud.age".publicKeys = [server];
  "user.age".publicKeys = [desktop server];
}
