{
  # Inputs-only flake: the pins for the jpe-nix estate's deployed hosts.
  #
  # Consume through `follows` from a top-level flake only. Library flakes keep
  # their own standalone defaults and never take this flake as an input; the
  # top-level flake overrides their shared roots:
  #
  #   inputs.pins.url = "github:jpe-nix/jpe-nix-inputs-pins";
  #   inputs.nixpkgs.follows = "pins/nixpkgs";
  #   inputs.<lib>.inputs.nixpkgs.follows = "pins/nixpkgs";
  #
  # flake.lock is the single place these revisions are chosen.
  description = "Nixpkgs, home-manager and nix-darwin pins for jpe-nix hosts";

  inputs = {
    # Release branch = the intended major pin. Bumping a release is an edit to
    # these four URLs, nothing else in the estate.
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";

    # For individual packages whose usable version outruns the stable release.
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Followers reference the inputs above through `follows`, not outputs.
  outputs = _: { };
}
