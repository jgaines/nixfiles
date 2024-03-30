# Nixfiles

This repo contains Nix files containing configuration for my home and work computers.  It's a WIP as I'm working towards capturing my current manual setups in Nix.

## Systems

The systems I intend to support in these scripts are:

| System              | OS                | Notes                            |
|---------------------|-------------------|----------------------------------|
| jgaines-test-nixos  | NixOS             | VM for initial setup and testing |
| jgaines-Desktop     | Linux Mint 21.3   | Home computer                    |
| jgaines.localdomain | Pop!_OS 22.04 LTS | Work laptop                      |

My work laptop will eventually be the only one still running a stand-alone
Home-Manager on top of a non-NixOS.

## Links

Just a bunch of random links which I'm using as documentation, inspiration, etc.

* https://zero-to-nix.com/
* https://flake.parts
* https://search.nixos.org
* https://github.com/nix-community/nixos-vscode-server
* https://discourse.nixos.org/t/set-up-nixos-home-manager-via-flake/29710/3
* https://github.com/elitak/nixos-infect
* https://nixos.org/guides/nix-pills/
* https://flakehub.com/
* https://nix-community.github.io/home-manager/options.xhtml
* https://tech.aufomm.com/my-nix-journey-use-nix-with-ubuntu
* https://www.tweag.io/blog/2022-09-29-the-nix-book-report/
* https://nixos-and-flakes.thiscute.world/
* https://github.com/F1bonacc1/process-compose#-launcher
* https://colmena.cli.rs/unstable/introduction.html
* https://librephoenix.com/2023-10-08-why-you-should-use-nixos.html
* https://mynixos.com/


### Dotfile Repos

* https://github.com/nmasur/dotfiles
* https://github.com/wahtique/dotfiles
* https://github.com/jnsgruk/nixos-config
* https://github.com/MatthewCroughan/nixcfg
* https://github.com/DavSanchez/nix-dotfiles
* https://github.com/wiltaylor/dotfiles
* https://github.com/wimpysworld/nix-config
* https://gitlab.com/librephoenix/nixos-config

### Alternates

Provide alternate front-ends to the standard nix commands.

* [devbox](https://www.jetpack.io/devbox) creates isolated, reproducible
  development environments that run anywhere. No Docker containers or Nix lang
  required.
* [devenv](https://devenv.sh/) - Fast, Declarative, Reproducible, and Composable
  Developer Environments using Nix
* [distrobox](https://distrobox.it/) - Simply put it’s a fancy wrapper around
  podman, docker or lilipod to create and start containers highly integrated
  with the hosts.
* [Tvix](https://tvix.dev) is a new implementation of Nix, a purely-functional
  package manager. It aims to have a modular implementation, in which different
  components can be reused or replaced based on the use-case.

### Random Other Things

Random things I've encountered during my journey to nix enlightenment that I'd
like to look at later.

* https://just.systems
* https://www.nushell.sh
