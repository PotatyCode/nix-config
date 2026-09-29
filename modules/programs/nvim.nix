{ inputs, ... }:

let
  nvimConfig = {
    config.vim = {
      options.shiftwidth = 2;
      viAlias = true;
      vimAlias = true;
      binds.whichKey.enable = true;

      autocomplete = {
        blink-cmp.enable = true;
      };
      utility = {
        mkdir.enable = true;
        motion = {
          flash-nvim.enable = true;
        };
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
        enableFormat = true;
        enableTreesitter = true;
        clang.enable = true;
        cmake.enable = true;
        zig.enable = true;
        rust = {
          extensions.rustaceanvim.enable = true;
          extensions.crates-nvim.enable = true;
        };
        nix = {
          enable = true;
          format.type = [ "nixfmt" ];
        };
      };
      theme = {
        enable = true;
        name = "gruber-darker";
        style = "dark";
      };
      telescope = {
        enable = true;
      };
      git = {
        gitsigns.enable = true;
      };
    };
  };

  mkNvim =
    pkgs:
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
