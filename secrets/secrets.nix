{config, ...}: let
  inherit (config.cute.pubkeys) aoi ena rin;
in {
  "nextcloud.age".publicKeys = [aoi];
  "user.age".publicKeys = [aoi ena rin];
}
