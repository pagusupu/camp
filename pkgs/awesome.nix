{
  stdenv,
  lib,
  pkgs,
}: let
  luaEnv = pkgs.luajit.withPackages (ps: [ps.lgi ps.ldoc]);
in
  stdenv.mkDerivation rec {
    pname = "awesome";
    version = "375d9d723550023f75ff0066122aba99fdbb2a93";
    src = pkgs.fetchFromGitHub {
      owner = "awesomeWM";
      repo = "awesome";
      rev = "375d9d723550023f75ff0066122aba99fdbb2a93";
      fetchSubmodules = false;
      sha256 = "sha256-9cIQvuXUPu8io2Qs3Q8n2WkF9OstdaGUt/+0FMrRkXk=";
    };
    patches = [];
    nativeBuildInputs = with pkgs; [
      cmake
      doxygen
      imagemagick
      makeWrapper
      pkg-config
      xmlto
      docbook_xml_dtd_45
      docbook_xsl
      findXMLCatalogs
      asciidoctor
    ];
    outputs = ["out" "doc"];
    FONTCONFIG_FILE = toString pkgs.texFunctions.fontsConf;
    propagatedUserEnvPkgs = [pkgs.hicolor-icon-theme];
    buildInputs = with pkgs; [
      (cairo.override {xcbSupport = true;})
      dbus
      gdk-pixbuf
      gobject-introspection
      git
      gtk3
      luaEnv
      libstartup_notification
      libxdg_basedir
      libxkbcommon
      librsvg
      nettools
      pango
      pcre2
      luajit
      luajitPackages.lgi
      luajitPackages.luacheck
      xcb-util-cursor
      xcbutilxrm
      xorg.libXau
      xorg.libXdmcp
      xorg.libxcb
      xorg.libxshmfence
      xorg.xcbutil
      xorg.xcbutilerrors
      xorg.xcbutilimage
      xorg.xcbutilkeysyms
      xorg.xcbutilrenderutil
      xorg.libpthreadstubs
      xorg.xcbutilwm
    ];
    cmakeFlags = [
      "-DGENERATE_MANPAGES=OFF"
      "-DOVERRIDE_VERSION=${version}"
      "-DLUA_LIBRARY=${pkgs.luajit}/lib/libluajit-5.1.so"
    ];
    GI_TYPELIB_PATH = "${pkgs.pango.out}/lib/girepository-1.0";
    LUA_CPATH = "${luaEnv}/lib/lua/${pkgs.luajit.luaversion}/?.so";
    LUA_PATH = "${luaEnv}/share/lua/${pkgs.luajit.luaversion}/?.lua;;";
    postInstall = ''
      mv "$out/bin/awesome" "$out/bin/.awesome-wrapped"
      makeWrapper "$out/bin/.awesome-wrapped" "$out/bin/awesome" \
        --set GDK_PIXBUF_MODULE_FILE "$GDK_PIXBUF_MODULE_FILE" \
        --add-flags '--search ${luaEnv}/lib/lua/${pkgs.luajit.luaversion}' \
        --add-flags '--search ${luaEnv}/share/lua/${pkgs.luajit.luaversion}' \
        --prefix GI_TYPELIB_PATH : "$GI_TYPELIB_PATH"
        wrapProgram $out/bin/awesome-client \
        --prefix PATH : "${pkgs.which}/bin"
    '';
    postPatch = ''
      patchShebangs tests/examples/_postprocess.lua
      patchShebangs tests/examples/_postprocess_cleanup.lua
    '';
  }
