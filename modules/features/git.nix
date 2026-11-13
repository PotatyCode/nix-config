{ self, inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.git-test = pkgs.git;
    };
}
