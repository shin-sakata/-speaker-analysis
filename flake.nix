{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      pythonEnv = pkgs.python3.withPackages (p: [
        p.openai
        p.autopep8
        p.pydantic
        p.ffmpeg-python
      ]);
    in
    {
      devShells.default = pkgs.mkShell {
        packages = [
          pythonEnv
        ];
        PYTHONPATH = "${pythonEnv}/${pythonEnv.sitePackages}";
      };
    }
  );
}
