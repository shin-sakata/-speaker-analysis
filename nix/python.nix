{ pkgs }:
let
  interpreter = pkgs.python3;
  poetryLock = builtins.readFile ../poetry.lock;
  poetryLockHash = builtins.hashString "sha256" poetryLock;
  pythonEnv = pkgs.poetry2nix.mkPoetryEnv {
    python = interpreter;
    projectDir = ../.;
  };
in {
  inherit interpreter poetryLockHash;
  env = pythonEnv;
}
