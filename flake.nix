{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      python3 = pkgs.python3;
      poetry = pkgs.poetry.override { inherit python3; };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = [
          poetry
          python3
          pkgs.ffmpeg
        ];
        PYTHONPATH = "${python3}/${python3.sitePackages}";
      };
    }
  );
}
