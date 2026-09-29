{ ... }:

{
  flake.nixosModule.authentik = { inputs, ... }: {
     imports = [
       inputs.authentik-nix.nixosModule.default
     ] 
     services.authentik = {
       enable = true
     }
  };
}
