{
    lib,
    stdenv,
    fetchurl,
    installShellFiles,
  }:

  let
    version = "0.15.0";

    systems = {
      x86_64-linux = {
        url = "https://github.com/dxupsh/dxup/releases/download/v${version}/dxup_Linux_x86_64.tar.gz";
        sha256 = "sha256-linux-x86_64";
      };
      aarch64-linux = {
        url = "https://github.com/dxupsh/dxup/releases/download/v${version}/dxup_Linux_arm64.tar.gz";
        sha256 = "sha256-linux-aarch64";
      };
      x86_64-darwin = {
        url = "https://github.com/dxupsh/dxup/releases/download/v${version}/dxup_Darwin_x86_64.tar.gz";
        sha256 = "sha256-darwin-x86_64";
      };
      aarch64-darwin = {
        url = "https://github.com/dxupsh/dxup/releases/download/v${version}/dxup_Darwin_arm64.tar.gz";
        sha256 = "sha256-darwin-aarch64";
      };
    };

    src = fetchurl systems.${stdenv.hostPlatform.system};
  in
  stdenv.mkDerivation {
    pname = "dxup";
    inherit version src;

    sourceRoot = ".";

    nativeBuildInputs = [ installShellFiles ];

    installPhase = ''
      install -Dm755 dxup $out/bin/dxup
      installShellCompletion --bash docs/completions/dxup.bash
      installShellCompletion --zsh docs/completions/_dxup
      installShellCompletion --fish docs/completions/dxup.fish
      installManPage docs/man/*.1
    '';

    meta = with lib; {
      description = "Reproducible development environments with Docker and Nix";
      homepage = "https://github.com/dxupsh/dxup";
      license = licenses.mit;
      maintainers = [ ];
      platforms = builtins.attrNames systems;
    };
  }
