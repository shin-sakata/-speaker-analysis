{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      python = pkgs.callPackage ./nix/python.nix { };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = [
          (pkgs.poetry.override { python3 = python.interpreter; } )
          python.interpreter
          python.env
          pkgs.ffmpeg
        ];
        PYTHONPATH = "${python.env}/${python.env.sitePackages}";
        POETORY_LOCK_HASH=python.poetryLockHash;
      };
    }
  );
}
