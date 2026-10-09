{...}: {
  config = {
    programs.chawan.enable = true;
    programs.chawan.settings = {
      buffer = {
        images = true;
      };
      network = {
        allow-http-from-file = true;
      };
    };
  };
}
