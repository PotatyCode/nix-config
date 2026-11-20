{
  inputs,
  self,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.nvim =
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;

        modules = [
          {
            config.vim = {
              viAlias = false;
              vimAlias = true;

              options = {
                number = true;
                relativenumber = true;
                shiftwidth = 2;
                tabstop = 2;
                expandtab = true;
                mouse = "a";
                clipboard = "unnamedplus";
              };

              theme = {
                enable = true;
                name = self.theme.name;
                style = "mocha";
              };
              dashboard.dashboard-nvim.enable = true;

              terminal.toggleterm.enable = true;

              statusline.lualine.enable = true;

              telescope.enable = true;

              treesitter.enable = true;

              binds.whichKey.enable = true;

              autocomplete.nvim-cmp.enable = true;

              utility.motion.flash-nvim.enable = true;

              languages = {
                enableFormat = true;
                enableTreesitter = true;
                nix.enable = true;
                rust.enable = true;
              };

              lsp = {
                enable = true;
                formatOnSave = true;
              };
            };
          }
        ];
      }).neovim;
  };
}
