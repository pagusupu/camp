{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: {
  options.cute.desktop.swaync = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.swaync {
    assertions = _lib.assertHm;
    home-manager.users.pagu = {
      home.packages = [pkgs.libnotify];
      services.swaync = {
        enable = true;
        # https://github.com/rose-pine/swaync
        settings = {
          cssPriority = "application";
          fit-to-screen = true;
          hide-on-action = true;
          hide-on-clear = false;
          image-visibility = "when-available";
          keyboard-shortcuts = true;
          layer = "overlay";
          layer-shell = true;
          positionX = "right";
          positionY = "top";
          script-fail-notify = false;
          timeout = 3;
          transition-time = 200;
          control-center-layer = "top";
          control-center-height = 600;
          control-center-width = 500;
          control-center-margin-top = 0;
          control-center-margin-bottom = 0;
          control-center-margin-right = 0;
          control-center-margin-left = 0;
          notification-2fa-action = true;
          notification-body-image-height = 100;
          notification-body-image-width = 200;
          notification-icon-size = 64;
          notification-inline-replies = false;
          notification-window-width = 500;
        };
        style = with config.colours.base16; /*css*/ ''
          * {
            all: unset;
            font-family: monospace;
            transition: 0.3s;
            font-size: 1.2rem;
          }

          .floating-notifications.background .notification-row {
            padding: 1rem;
          }

          .floating-notifications.background .notification-row .notification-background {
            border-radius: 0.5rem;
            background-color: #${A1};
            color: #${A6};
            border: 1px solid #${A4};
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .notification {
            padding: 0.5rem;
            border-radius: 0.5rem;
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .notification.critical {
            border: 1px solid #${B1};
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .notification
            .notification-content
            .summary {
            margin: 0.5rem;
            color: #${A6};
            font-weight: bold;
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .notification
            .notification-content
            .body {
            margin: 0.5rem;
            color: #${A5};
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .notification
            > *:last-child
            > * {
            min-height: 3rem;
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .notification
            > *:last-child
            > *
            .notification-action {
            border-radius: 0.5rem;
            color: #${A6};
            background-color: #${A2};
            border: 1px solid #${A4};
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .notification
            > *:last-child
            > *
            .notification-action:hover {
            background-color: #${A3};
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .notification
            > *:last-child
            > *
            .notification-action:active {
            background-color: #${A4};
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .close-button {
            margin: 0.5rem;
            padding: 0.25rem;
            border-radius: 0.5rem;
            color: #${A6};
            background-color: #${B1};
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .close-button:hover {
            color: #${A1};
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .close-button:active {
            background-color: #${B3};
          }

          .control-center {
            border-radius: 0.5rem;
            margin: 1rem;
            background-color: #${A1};
            color: #${A6};
            padding: 1rem;
            border: 1px solid #${A4};
          }

          .control-center .widget-title {
            color: #${B3};
            font-weight: bold;
          }

          .control-center .widget-title button {
            border-radius: 0.5rem;
            color: #${A6};
            background-color: #${A2};
            border: 1px solid #${A4};
            padding: 0.5rem;
          }

          .control-center .widget-title button:hover {
            background-color: #${A3};
          }

          .control-center .widget-title button:active {
            background-color: #${A4};
          }

          .control-center .notification-row .notification-background {
            border-radius: 0.5rem;
            margin: 0.5rem 0;
            background-color: #${A2};
            color: #${A6};
            border: 1px solid #${A4};
          }

          .control-center .notification-row .notification-background .notification {
            padding: 0.5rem;
            border-radius: 0.5rem;
          }

          .control-center
            .notification-row
            .notification-background
            .notification.critical {
            border: 1px solid #${B1};
          }

          .control-center
            .notification-row
            .notification-background
            .notification
            .notification-content {
            color: #${A6};
          }

          .control-center
            .notification-row
            .notification-background
            .notification
            .notification-content
            .summary {
            margin: 0.5rem;
            color: #${B5};
            font-weight: bold;
          }

          .control-center
            .notification-row
            .notification-background
            .notification
            .notification-content
            .body {
            margin: 0.5rem;
            color: #${A5};
          }

          .control-center
            .notification-row
            .notification-background
            .notification
            > *:last-child
            > * {
            min-height: 3rem;
          }

          .control-center
            .notification-row
            .notification-background
            .notification
            > *:last-child
            > *
            .notification-action {
            border-radius: 0.5rem;
            color: #${A6};
            background-color: #${A2};
            border: 1px solid #${A4};
          }

          .control-center
            .notification-row
            .notification-background
            .notification
            > *:last-child
            > *
            .notification-action:hover {
            background-color: #${A3};
          }

          .control-center
            .notification-row
            .notification-background
            .notification
            > *:last-child
            > *
            .notification-action:active {
            background-color: #${A4};
          }

          .control-center .notification-row .notification-background .close-button {
            margin: 0.5rem;
            padding: 0.25rem;
            border-radius: 0.5rem;
            color: #${A6};
            background-color: #${B1};
          }

          .control-center .notification-row .notification-background .close-button:hover {
            color: #${A1};
          }

          .control-center
            .notification-row
            .notification-background
            .close-button:active {
            background-color: #${B3};
          }

          progressbar,
          progress,
          trough {
            border-radius: 0.5rem;
          }

          .notification.critical progress {
            background-color: #${B6};
          }

          .notification.low progress,
          .notification.normal progress {
            background-color: #${B4};
          }

          trough {
            background-color: #${A2};
          }

          .control-center trough {
            background-color: #${A2};
          }

          .control-center-dnd {
            margin: 1rem 0;
            border-radius: 0.5rem;
          }

          .control-center-dnd slider {
            background: #${A3};
            border-radius: 0.5rem;
          }

          .widget-dnd {
            color: #${A5};
          }

          .widget-dnd > switch {
            border-radius: 0.5rem;
            background: #${A3};
            border: 1px solid #${A4};
          }

          .widget-dnd > switch:checked slider {
            background: #31748f;
          }

          .widget-dnd > switch slider {
            background: #${A4};
            border-radius: 0.5rem;
            margin: 0.25rem;
          }
        '';
      };
    };
  };
}
