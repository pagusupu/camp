{inputs, ...}: {
  imports = [inputs.devshell.flakeModule];
  perSystem.devshells = {pkgs, ...}: {
    rust = {
      packages = with pkgs; [
        cargo
        rustc
        rustfmt
        rust-analyzer
        # rustlings
        gcc
        rustlings
      ];
      name = "rust";
      motd = "Rust!";
    };
  };
}
