{
  lib,
  inputs,
  self,
  ...
}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.desktop = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      imports = [self.wrapperModules.niri];
      terminal = lib.getExe self'.packages.terminal;
      env = {
        EDITOR = lib.getExe self'.packages.neovim;
      };
    };
    packages.terminal =
      (inputs.wrappers.wrapper-modules.kitty.apply {
        inherit pkgs;
        import = [self.wrappersModules.kitty];
        shell = lib.getExe self'.packages.environment;
      }).wrapper;
    packages.environment = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = self'.packages.fish;
      runtimeInputs = [
        # nix stuff
        pkgs.nil
        pkgs.nixd
        pkgs.statix
        pkgs.alejandra
        pkgs.manix
        pkgs.nix-inspect

        pkgs.fzf
        pkgs.exa
        pkgs.zoxide
        pkgs.dust
        pkgs.dust

        #wrapped
        self'.packages.git
        self'.packages.jujutsu
        self'.packages.jjui
      ];
    };
  };
}
