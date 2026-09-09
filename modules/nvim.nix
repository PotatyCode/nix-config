{ inputs, ... }:

let
  nvimConfig = {
    config.vim = {
      viAlias = true;
      vimAlias = true;

      autocomplete = {
        blink-cmp.enable = true;
      };
      spellcheck = {
        enable = true;
      };

      lsp = {
        enable = true;
        formatOnSave = true;
        trouble.enable = true;
        presets.rust-analyzer.enable = false;
      };

      debugger = {
        nvim-dap.enable = true;
      };

      languages = {
        clang.enable = true;
        cmake.enable = true; 
        zig.enable = true;
        rust = {
          extensions.rustaceanvim.enable = true;
          extensions.crates-nvim.enable = true;
        };
       };
       theme = {
         enable = true;
         name = "oxocarbon";
         style = "dark";
       };
    };
  };

  mkNvim = pkgs:
    (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [ nvimConfig ];
    }).neovim;

in
{
  perSystem = { pkgs, ... }: {
    packages.nvim = mkNvim pkgs;
  };

  flake.nixosModules.nvim = { pkgs, ... }: {
    environment.systemPackages = [
      (mkNvim pkgs)
    ];
  };
}
