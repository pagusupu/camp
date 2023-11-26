let
  server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPPaiKWOdvrIUz20movhyP/Ag/09E/UOEmrrugbjmpfT pagu@server";
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM96wFExSY7APK/zcIs957BxI7Nt2AsBQx8enoJldv9q pagu@desktop";
in {
  "nextcloud.age".publicKeys = [server];
  "userPass.age".publicKeys = [server];
  "deskPass.age".publicKeys = [desktop];
}
