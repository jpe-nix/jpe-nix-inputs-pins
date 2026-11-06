# jpe-nix-inputs-pins

An inputs-only flake that pins `nixpkgs`, `nixpkgs-unstable`, `home-manager` and `nix-darwin` for jpe-nix hosts.

[![CI][ci-badge]][ci]

[ci-badge]: https://github.com/jpe-nix/jpe-nix-inputs-pins/actions/workflows/ci.yml/badge.svg
[ci]: https://github.com/jpe-nix/jpe-nix-inputs-pins/actions/workflows/ci.yml
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Installation

Add it as an input of a top-level flake:

```nix
inputs.pins.url = "github:jpe-nix/jpe-nix-inputs-pins";
```

## Usage

The flake has no outputs. A consumer uses its inputs through `follows`:

```nix
{
  inputs = {
    pins.url = "github:jpe-nix/jpe-nix-inputs-pins";
    nixpkgs.follows = "pins/nixpkgs";

    some-library = {
      url = "github:owner/some-library";
      inputs.nixpkgs.follows = "pins/nixpkgs";
      inputs.nixpkgs-unstable.follows = "pins/nixpkgs-unstable";
      inputs.home-manager.follows = "pins/home-manager";
      inputs.darwin.follows = "pins/nix-darwin";
    };
  };
}
```

After `nix flake update pins`, the consumer's lock carries these exact revisions.

## Contract

- **Only a top-level flake consumes it.** Library flakes keep their own standalone defaults. They never take this
  flake as an input. The top-level flake overrides each library's shared roots. Each library passes its roots to
  its own children through `follows`, so one override reaches every leaf.
- **`flake.lock` is the one place revisions are chosen.** A release bump, such as 26.05 to 26.11, edits the four
  URLs in `flake.nix`.

## Contributing

Open a pull request. CI checks the flake and the lock.

## License

[MIT](LICENSE)

---

Docs: <https://docs.jacobpevans.com>
