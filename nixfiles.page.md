# nixfiles
 
> Common commands to managing my Nix Flake files.
> More information: <https://github.com/jgaines/nixfiles>.
 
- Rebuild and switch to latest NixOS configuration:
 
`cd ~/nixfiles` 
`sudo nixos-rebuild switch --flake .`
 
- Rebuild and switch to latest Home-Manger configuration:
 
`cd ~/nixfiles` 
`home-manager switch --flake .`
 
- Update to latest releases:
 
`cd ~/nixfiles` 
`nix flake update`

- Optimize Nix Store:

`nix-store --optimize`
 
- Garbage collect Nix Store:

`nix-store --gc`
