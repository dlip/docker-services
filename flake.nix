{
  description = "A very basic flake";

  outputs = { self, nixpkgs }:
    let
      render = ''
        ---
        version: "2.1"
        services:
          ${import ./syncthing.nix}
      '';
    in {

      packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

      defaultPackage.x86_64-linux =
        with import nixpkgs { system = "x86_64-linux"; };
        writeTextFile {
          name = "docker-compose.yaml";
          text = render;
        };

    };
}
