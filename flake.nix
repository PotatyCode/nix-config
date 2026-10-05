{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-26.05";

    nixos-wsl.url = "github:nix-community/NixOS-WSl";
    disko.url = "github:nix-community/disko";
    flake-parts.url = "github:hercules-ci/flake-parts";
   import-tree.url = "github:vic/import-tree";

    nvf.url = "github:NotAShelf/nvf";
    vpn-confinement.url = "github:Maroka-chan/VPN-Confinement";

    nixarr.url = "github:nix-media-server/nixarr";
    authentik-nix = {
      url = "github:nix-community/authentik-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };

  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } 
      (inputs.import-tree ./modules);
}
