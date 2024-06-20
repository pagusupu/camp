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
        style = let
          inherit (config.scheme) withHashtag;
        in ''
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
            background-color: ${withHashtag.base00};
            color: ${withHashtag.base05};
            border: 1px solid ${withHashtag.base03};
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
            border: 1px solid ${withHashtag.base08};
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .notification
            .notification-content
            .summary {
            margin: 0.5rem;
            color: ${withHashtag.base05};
            font-weight: bold;
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .notification
            .notification-content
            .body {
            margin: 0.5rem;
            color: ${withHashtag.base04};
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
            color: ${withHashtag.base05};
            background-color: ${withHashtag.base01};
            border: 1px solid ${withHashtag.base03};
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .notification
            > *:last-child
            > *
            .notification-action:hover {
            background-color: ${withHashtag.base02};
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .notification
            > *:last-child
            > *
            .notification-action:active {
            background-color: ${withHashtag.base03};
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .close-button {
            margin: 0.5rem;
            padding: 0.25rem;
            border-radius: 0.5rem;
            color: ${withHashtag.base05};
            background-color: ${withHashtag.base08};
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .close-button:hover {
            color: ${withHashtag.base00};
          }

          .floating-notifications.background
            .notification-row
            .notification-background
            .close-button:active {
            background-color: ${withHashtag.base0A};
          }

          .control-center {
            border-radius: 0.5rem;
            margin: 1rem;
            background-color: ${withHashtag.base00};
            color: ${withHashtag.base05};
            padding: 1rem;
            border: 1px solid ${withHashtag.base03};
          }

          .control-center .widget-title {
            color: ${withHashtag.base0A};
            font-weight: bold;
          }

          .control-center .widget-title button {
            border-radius: 0.5rem;
            color: ${withHashtag.base05};
            background-color: ${withHashtag.base01};
            border: 1px solid ${withHashtag.base03};
            padding: 0.5rem;
          }

          .control-center .widget-title button:hover {
            background-color: ${withHashtag.base02};
          }

          .control-center .widget-title button:active {
            background-color: ${withHashtag.base03};
          }

          .control-center .notification-row .notification-background {
            border-radius: 0.5rem;
            margin: 0.5rem 0;
            background-color: ${withHashtag.base01};
            color: ${withHashtag.base05};
            border: 1px solid ${withHashtag.base03};
          }

          .control-center .notification-row .notification-background .notification {
            padding: 0.5rem;
            border-radius: 0.5rem;
          }

          .control-center
            .notification-row
            .notification-background
            .notification.critical {
            border: 1px solid ${withHashtag.base08};
          }

          .control-center
            .notification-row
            .notification-background
            .notification
            .notification-content {
            color: ${withHashtag.base05};
          }

          .control-center
            .notification-row
            .notification-background
            .notification
            .notification-content
            .summary {
            margin: 0.5rem;
            color: ${withHashtag.base0C};
            font-weight: bold;
          }

          .control-center
            .notification-row
            .notification-background
            .notification
            .notification-content
            .body {
            margin: 0.5rem;
            color: ${withHashtag.base04};
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
            color: ${withHashtag.base05};
            background-color: ${withHashtag.base01};
            border: 1px solid ${withHashtag.base03};
          }

          .control-center
            .notification-row
            .notification-background
            .notification
            > *:last-child
            > *
            .notification-action:hover {
            background-color: ${withHashtag.base02};
          }

          .control-center
            .notification-row
            .notification-background
            .notification
            > *:last-child
            > *
            .notification-action:active {
            background-color: ${withHashtag.base03};
          }

          .control-center .notification-row .notification-background .close-button {
            margin: 0.5rem;
            padding: 0.25rem;
            border-radius: 0.5rem;
            color: ${withHashtag.base05};
            background-color: ${withHashtag.base08};
          }

          .control-center .notification-row .notification-background .close-button:hover {
            color: ${withHashtag.base00};
          }

          .control-center
            .notification-row
            .notification-background
            .close-button:active {
            background-color: ${withHashtag.base0A};
          }

          progressbar,
          progress,
          trough {
            border-radius: 0.5rem;
          }

          .notification.critical progress {
            background-color: ${withHashtag.base0D};
          }

          .notification.low progress,
          .notification.normal progress {
            background-color: ${withHashtag.base0B};
          }

          trough {
            background-color: ${withHashtag.base01};
          }

          .control-center trough {
            background-color: ${withHashtag.base01};
          }

          .control-center-dnd {
            margin: 1rem 0;
            border-radius: 0.5rem;
          }

          .control-center-dnd slider {
            background: ${withHashtag.base02};
            border-radius: 0.5rem;
          }

          .widget-dnd {
            color: ${withHashtag.base04};
          }

          .widget-dnd > switch {
            border-radius: 0.5rem;
            background: ${withHashtag.base02};
            border: 1px solid ${withHashtag.base03};
          }

          .widget-dnd > switch:checked slider {
            background: #31748f;
          }

          .widget-dnd > switch slider {
            background: ${withHashtag.base03};
            border-radius: 0.5rem;
            margin: 0.25rem;
          }
        '';
      };
    };
  };
}
