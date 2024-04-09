{
  description = "jgaines flake";

  outputs = inputs@{self, nixpkgs, nixpkgs-stable, home-manager,
                    stylix, blocklist-hosts, hyprland-plugins, kickstart-nix-nvim, ...}:
  let
    # TODO: figure out how to get as much of this as possible from the system.
    # Even if we're logged into a live ISO environment, doing a manual install,
    # some of this stuff should be able to be determined from the system.
    # Not sure that's possible, something about impure vs. pure builds.
    systemSettings = {
      system = "x86_64-linux";
      hostname = "jgaines-test-nixos";
      profile = "personal";
      timezone = "America/Detroit";
      locale = "en_US.UTF-8";
      bootMode = "bios"; # uefi or bios
      bootMountPoint = ""; # mount path for efi boot partition; only used for uefi boot mode
      grubDevice = "/dev/vda"; # device identifier for grub; only used for legacy (bios) boot mode
    };

    userSettings = rec {
      username = "jgaines"; # username
      name = "John Gaines"; # name/identifier
      email = "me@jgaines.com"; # email (used for certain configurations)
      dotfilesDir = "~/nixfiles"; # absolute path of the local repo
      theme = "uwunicorn-yt"; # selcted theme from my themes directory (./themes/)
      wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
      # window manager type (hyprland or x11) translator
      wmType = if (wm == "hyprland") then "wayland" else "x11";
      browser = "chromium"; # Default browser; must select one from ./user/app/browser/
      term = "kitty"; # Default terminal command;
      font = "Intel One Mono"; # Selected font
      fontPkg = pkgs.intel-one-mono; # Font package
      editor = "nano"; # Default editor;
      };

    lib = nixpkgs.lib;
    pkgs = import nixpkgs {
      system = systemSettings.system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    };
    pkgs-stable = import nixpkgs-stable {
      system = systemSettings.system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    };

  in {
    homeConfigurations = {
      jgaines = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
        extraSpecialArgs = {
          inherit nixpkgs-stable;
          inherit systemSettings;
          inherit userSettings;
          inherit (inputs) stylix;
          inherit (inputs) hyprland-plugins;
        };
      };
    };

    nixosConfigurations = {
      jgaines-test-nixos = lib.nixosSystem {
        system = systemSettings.system;
        modules = [
          ./configuration.nix
        ];
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit (inputs) stylix;
          inherit (inputs) blocklist-hosts;
          inherit (inputs) kickstart-nix-nvim;
        };
      };
    };

  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    blocklist-hosts = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      flake = false;
    };

    kickstart-nix-nvim = {
      url = "github:jgaines/kickstart-nix.nvim";
      flake = true;
    };
  };
}