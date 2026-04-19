{ self, inputs, pkgs, ...}: {
    imports = [ ./hardware.nix ];

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };

    networking = {
      hostName = "nixos_btw";
      networkmanager.enable = true;
      proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    };

    hardware = {
      bluetooth.enable = true;
      # Ensure graphics and Intel drivers are enabled
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          intel-media-driver
        ];
      };
    };


    time.timeZone = "Europe/Warsaw";
    time.hardwareClockInLocalTime = true;

    users.users.beholder = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };

    programs = {
      fish.enable = true;
      niri.enable = true;
      firefox.enable = true;
      dconf = {
        enable = true;
        profiles.user.databases = [{
          settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
        }];
      };
      git = {
        enable = true;
        config = {
          init.defaultBranch = "master";
          user.name = "beholder";
          user.email = "kurganskiyvladislav@gmail.com";
        };
      };
    };

    services = {
      displayManager = {
        gdm.enable = true;
        defaultSession = "niri";
      };
      pipewire = {
        enable = true;
        pulse.enable = true;
      };
      xserver.xkb = {
        layout = "pl,ru";
        options = "grp:win_space_toggle";
      };
    };

    environment = {
      systemPackages = with pkgs; [
        antigravity
        spotify
        telegram-desktop
        neovim
        wget
        git
        gh
        curl
        kitty
        alacritty
        brightnessctl
        pavucontrol
        bluetui
        zed-editor
        nautilus
        sushi
        wl-clipboard
      ];

      sessionVariables = {
        LIBVA_DRIVER_NAME = "iHD";
        GTK_THEME = "Adwaita:dark";
        EDITOR = "nvim";
      };
    };

    system.stateVersion = "25.11";
}
