# NixOS Configuration

Welcome to my fully declarative, modular NixOS dotfiles!

## Architecture & How it Works

This repository abandons the traditional, monolithic `flake.nix` in favor of a highly automated and modular setup. It is built upon two core libraries that keep the codebase exceptionally clean:

### 1. The Core Engines
* **`flake-parts`**: This framework implements the module system *for* flakes. Rather than defining rigid `nixosConfigurations` inside the root `flake.nix`, this allows us to declare bits of our flake architecture dynamically across various files within the repository.
* **`import-tree`**: This utility crawls the `./modules` directory recursively. Every `.nix` file it discovers is automatically evaluated and stitched into the top-level `flake-parts` module system. You **never** need to manually `import` files in the root `flake.nix`.

### 2. The Flow of Evaluation

**A. `flake.nix` (The Stub)**
The root file only handles fetching inputs (like `nixpkgs`) and passing the `./modules` folder to `import-tree` and `flake-parts`. It acts as a pure entryway.

**B. Defining Building Blocks (`configuration.nix`)**
Instead of directly building a system, we create reusable, compartmentalized pieces. For example, in `modules/hosts/neobehier/configuration.nix`, we attach configurations to the flake using:
```nix
flake.nixosModules.neobehier = { config, pkgs, ... }: { ... }
```
This just saves that configuration as a modular piece.

**C. Gluing the System Together (`default.nix`)**
To turn those pieces into an actual bootable system, we instantiate them. In `modules/hosts/neobehier/default.nix`, we define the final configuration target by importing our previously defined modular pieces:
```nix
flake.nixosConfigurations.nixosbtw = inputs.nixpkgs.lib.nixosSystem {
  modules = [ self.nixosModules.neobehier ];
};
```

## System Management

### Rebuilding the System
Because the `default.nix` instantiated the system as `nixosbtw`, that defines the name of your specific output. Apply configuration changes by running from the root repository directory:

```bash
sudo nixos-rebuild switch --flake .#nixosbtw
```

### Expanding the System
* **Adding a feature**: Create a new `.nix` file anywhere in `modules/features/` and format it as `flake.nixosModules.<feature> = { ... }`.
* **Adding a new machine**: Create a new folder in `modules/hosts/`, define its traits, and export its unique `flake.nixosConfigurations.<hostname> = ...`. It will automatically be picked up without touching `flake.nix`.
