let
  server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPPaiKWOdvrIUz20movhyP/Ag/09E/UOEmrrugbjmpfT pagu@server";
in {
  "nextcloud.age".publicKeys = [server];
  "userPass.age".publicKeys = [server];
}
