{
  description = "jgaines Home Manager flake";

  inputs = {
    # Used for system packages
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    # Used for user packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
  };

  outputs = {nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
  
    red-latest = final: prev: {
      # Well, this is properly formed and all, but it doesn't work.
      # I'm thinking it's because REBOL is such a piece of crap.
      # And it might have something to do with the fact that I'm not
      # running on nixos.
      # nix run nixpkgs#nurl -- https://github.com/red/red
      red = prev.red.overrideAttrs (old: {
        pname = "red-latest";
        version = "0.6.5";
        src = prev.fetchFromGitHub {
          owner = "red";
          repo = "red";
          rev = "181d7faeab0381d7a86575847918a4ab05e68503";
          hash = "sha256-QD4dtwH5R2kD7yLFYo0n1aQ063KoBcfoAhG3RqVlxco=";
        };
      });
    };
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowBroken = false;
      };
      overlays = [
        # red-latest
      ];
    };

    globals = let baseName = "jgaines.com";
    in rec {
      user = "jgaines";
      fullName = "John Gaines";
      gitName = fullName;
      gitEmail = "me@jgaines.com";
      dotfilesRepo = "https://github.com/jgaines/nixfiles";
    }; 

  in {

    packages.x86_64-linux.default = home-manager.packages.x86_64-linux.default;
    homeConfigurations."jgaines" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./home.nix
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
}