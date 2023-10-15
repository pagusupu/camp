{
  pkgs,
  config,
  lib,
  ...
}: {
  options.cute.programs.firefox = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.firefox.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-beta;
      profiles."pagu" = {
        search = {
          default = "DuckDuckGo";
          force = true;
          order = [
            "DuckDuckGo"
            "Google"
          ];
        };
        settings = {
          "browser.startup.homepage" = "http://server:8122";
          "browser.aboutConfig.showWarning" = false;
          "browser.bookmarks.defaultLocation" = "toolbar";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "layers.acceleration.force-enabled" = true;
          "gfx.webrender.all" = true;
          "svg.context-properties.content.enabled" = true;
        };
        userContent = ''
          :root {
            scrollbar-width: none !important;
          }
          @-moz-document url(about:privatebrowsing) {
            :root {
              scrollbar-width: none !important;
            }
          }
        '';
        userChrome = ''
          :root {
            --sfwindow: #${config.cute.colours.primary.bg};
            --sfsecondary: #${config.cute.colours.normal.black};
          }
          .urlbarView {
            display: none !important;
          }
          #tabbrowser-tabs:not([movingtab])
                   > #tabbrowser-arrowscrollbox
                   > .tabbrowser-tab
                   > .tab-stack
                   > .tab-background[multiselected='true'],
                 #tabbrowser-tabs:not([movingtab])
                   > #tabbrowser-arrowscrollbox
                   > .tabbrowser-tab
                   > .tab-stack
                   > .tab-background[selected='true'] {
                   background-image: none !important;
                   background-color: var(--sfsecondary) !important;
                 }
                 #navigator-toolbox {
            background-color: var(--sfwindow) !important;
          }
          :root
            --toolbar-bgcolor: var(--sfwindow) !important;
                   --tabs-border-color: var(--sfsecondary) !important;
                   --lwt-sidebar-background-color: var(--sfwindow) !important;
                   --lwt-toolbar-field-focus: var(--sfsecondary) !important;
          }
          #sidebar-box,
                 .sidebar-placesTree {
                   background-color: var(--sfwindow) !important;
                 }
          .tab-close-button {
                   display: none;
                 }
                 .tabbrowser-tab:not([pinned]) .tab-icon-image {
                   display: none !important;
                 }
                 #nav-bar:not([tabs-hidden='true']) {
                   box-shadow: none;
                 }
                 #tabbrowser-tabs[haspinnedtabs]:not([positionpinnedtabs])
                   > #tabbrowser-arrowscrollbox
                   > .tabbrowser-tab[first-visible-unpinned-tab] {
                   margin-inline-start: 0 !important;
                 }
                 :root {
                   --toolbarbutton-border-radius: 0 !important;
                   --tab-border-radius: 0 !important;
                   --tab-block-margin: 0 !important;
                 }
                 .tab-background {
                   border-right: 0px solid rgba(0, 0, 0, 0) !important;
                   margin-left: -4px !important;
                 }
                 .tabbrowser-tab:is([visuallyselected='true'], [multiselected])
                   > .tab-stack
                   > .tab-background {
                   box-shadow: none !important;
                 }
                 .tabbrowser-tab[last-visible-tab='true'] {
                   padding-inline-end: 0 !important;
                 }
                 #tabs-newtab-button {
                   padding-left: 0 !important;
                 }
          #urlbar-input-container {
                   background-color: var(--sfsecondary) !important;
                   border: 1px solid rgba(0, 0, 0, 0) !important;
                 }
                 #urlbar-container {
                   margin-left: 0 !important;
                 }
                 #urlbar[focused='true'] > #urlbar-background {
                   box-shadow: none !important;
                 }
                 #navigator-toolbox {
                   border: none !important;
                 }
                 .bookmark-item .toolbarbutton-icon {
                   display: none;
                 }
                 toolbarbutton.bookmark-item:not(.subviewbutton) {
                   min-width: 1.6em;
                 }
          #tracking-protection-icon-container,
                 #urlbar-zoom-button,
                 #star-button-box,
                 #pageActionButton,
                 #pageActionSeparator,
                 #tabs-newtab-button,
                 #back-button,
                 #PanelUI-button,
                 #forward-button,
                 .tab-secondary-label {
                   display: none !important;
                 }
                 .urlbarView-url {
                   color: #dedede !important;
                 }
          #context-navigation,
                 #context-savepage,
                 #context-pocket,
                 #context-sendpagetodevice,
                 #context-selectall,
                 #context-viewsource,
                 #context-inspect-a11y,
                 #context-sendlinktodevice,
                 #context-openlinkinusercontext-menu,
                 #context-bookmarklink,
                 #context-savelink,
                 #context-savelinktopocket,
                 #context-sendlinktodevice,
                 #context-searchselect,
                 #context-sendimage,
                 #context-print-selection {
                   display: none !important;
                 }
                 #context_bookmarkTab,
                 #context_moveTabOptions,
                 #context_sendTabToDevice,
                 #context_reopenInContainer,
                 #context_selectAllTabs,
                 #context_closeTabOptions {
                   display: none !important;
                 }
          #system-toolbar {
            display: none !important;
          }
        '';
      };
    };
  };
}
