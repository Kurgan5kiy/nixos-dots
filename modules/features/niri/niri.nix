{ self, inputs, ... }: {

  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;

      settings = {
        include = [
          "${./unconfigurable.kdl}"
        ];

        spawn-at-startup = [
          (lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia)
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        ];

        input = {
          keyboard = {
            xkb = {
              layout = "pl,ru";
              options = "grp:win_space_toggle";
            };
            numlock = _: {};
          };

          touchpad = {
            tap = _: {};
            natural-scroll = _: {};
          };
        };

        layout = {
          gaps = 16;
          center-focused-column = "never";

          preset-column-widths = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
            { proportion = 1.0; }
          ];

          default-column-width.proportion = 1.0;

          focus-ring.off = _: {};

          border = {
            width = 4;
            active-color = "#ffc87f";
            inactive-color = "#505050";
            urgent-color = "#505050";
          };

          shadow = {
            softness = 30;
            spread = 5;
            color = "#0007";
          };
        };

        hotkey-overlay.skip-at-startup = _: {};
        prefer-no-csd = _: {};
        screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

        binds = let
          noctaliaExe = lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia;
        in {
          "MouseBack".toggle-overview = _: {};
          "Mod+Shift+Slash".show-hotkey-overlay = _: {};

          "Mod+V".spawn-sh = "${noctaliaExe} ipc call clipboard toggle";

          "Mod+Left".focus-column-left = _: {};
          "Mod+Down".focus-window-down = _: {};
          "Mod+Up".focus-window-up = _: {};
          "Mod+Right".focus-column-right = _: {};
          "Mod+H".focus-column-left = _: {};
          "Mod+L".focus-column-right = _: {};

          "Mod+Ctrl+Left".move-column-left = _: {};
          "Mod+Ctrl+Down".move-window-down = _: {};
          "Mod+Ctrl+Up".move-window-up = _: {};
          "Mod+Ctrl+Right".move-column-right = _: {};
          "Mod+Shift+H".move-column-left = _: {};
          "Mod+Shift+J".move-window-down = _: {};
          "Mod+Shift+K".move-window-up = _: {};
          "Mod+Shift+L".move-column-right = _: {};

          "Mod+Home".focus-column-first = _: {};
          "Mod+End".focus-column-last = _: {};
          "Mod+Ctrl+Home".move-column-to-first = _: {};
          "Mod+Ctrl+End".move-column-to-last = _: {};

          "Mod+Shift+Left".focus-monitor-left = _: {};
          "Mod+Shift+Down".focus-monitor-down = _: {};
          "Mod+Shift+Up".focus-monitor-up = _: {};
          "Mod+Shift+Right".focus-monitor-right = _: {};
          "Mod+Ctrl+H".focus-monitor-left = _: {};
          "Mod+Ctrl+J".focus-monitor-down = _: {};
          "Mod+Ctrl+K".focus-monitor-up = _: {};
          "Mod+Ctrl+L".focus-monitor-right = _: {};

          "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = _: {};
          "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = _: {};
          "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = _: {};
          "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = _: {};
          "Mod+Shift+Ctrl+H".move-column-to-monitor-left = _: {};
          "Mod+Shift+Ctrl+J".move-column-to-monitor-down = _: {};
          "Mod+Shift+Ctrl+K".move-column-to-monitor-up = _: {};
          "Mod+Shift+Ctrl+L".move-column-to-monitor-right = _: {};

          "Mod+J".focus-workspace-down = _: {};
          "Mod+K".focus-workspace-up = _: {};
          "Mod+U".focus-workspace-down = _: {};
          "Mod+I".focus-workspace-up = _: {};
          "Mod+Ctrl+Page_Down".move-column-to-workspace-down = _: {};
          "Mod+Ctrl+Page_Up".move-column-to-workspace-up = _: {};
          "Mod+Ctrl+U".move-column-to-workspace-down = _: {};
          "Mod+Ctrl+I".move-column-to-workspace-up = _: {};

          "Mod+Shift+Page_Down".move-workspace-down = _: {};
          "Mod+Shift+Page_Up".move-workspace-up = _: {};
          "Mod+Shift+U".move-workspace-down = _: {};
          "Mod+Shift+I".move-workspace-up = _: {};

          "Mod+WheelScrollRight".focus-column-right = _: {};
          "Mod+WheelScrollLeft".focus-column-left = _: {};
          "Mod+Ctrl+WheelScrollRight".move-column-right = _: {};
          "Mod+Ctrl+WheelScrollLeft".move-column-left = _: {};

          "Mod+Shift+WheelScrollDown".focus-column-right = _: {};
          "Mod+Shift+WheelScrollUp".focus-column-left = _: {};
          "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = _: {};
          "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = _: {};

          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;

          "Mod+Shift+1".move-column-to-workspace = 1;
          "Mod+Shift+2".move-column-to-workspace = 2;
          "Mod+Shift+3".move-column-to-workspace = 3;
          "Mod+Shift+4".move-column-to-workspace = 4;
          "Mod+Shift+5".move-column-to-workspace = 5;
          "Mod+Shift+6".move-column-to-workspace = 6;
          "Mod+Shift+7".move-column-to-workspace = 7;
          "Mod+Shift+8".move-column-to-workspace = 8;
          "Mod+Shift+9".move-column-to-workspace = 9;

          "Mod+BracketLeft".consume-or-expel-window-left = _: {};
          "Mod+BracketRight".consume-or-expel-window-right = _: {};

          "Mod+Comma".consume-window-into-column = _: {};
          "Mod+Period".expel-window-from-column = _: {};

          "Mod+Shift+R".switch-preset-column-width = _: {};
          "Mod+Ctrl+R".reset-window-height = _: {};
          "Mod+F".maximize-column = _: {};
          "Mod+Shift+F".fullscreen-window = _: {};
          "Mod+Ctrl+F".expand-column-to-available-width = _: {};
          "Mod+C".center-column = _: {};
          "Mod+Ctrl+C".center-visible-columns = _: {};

          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";

          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";

          "Mod+Shift+V".toggle-window-floating = _: {};
          "Mod+W".toggle-column-tabbed-display = _: {};

          "Print".screenshot = _: {};
          "Ctrl+Print".screenshot-screen = _: {};
          "Alt+Print".screenshot-window = _: {};

          "Mod+Shift+E".quit = _: {};
          "Ctrl+Alt+Delete".quit = _: {};
          "Mod+Shift+P".power-off-monitors = _: {};
        };
      };

    };

  };

}
