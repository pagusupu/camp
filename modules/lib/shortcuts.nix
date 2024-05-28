{
  config,
  _lib,
  ...
}: {
  _module.args._lib = {
    mkAssert = a: b: [
      {
        assertion = a;
        message = b;
      }
    ];
    assertNginx = _lib.mkAssert config.cute.services.web.nginx "requires nginx service.";
  };
}
