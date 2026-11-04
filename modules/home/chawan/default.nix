{...}: {
  config = {
    programs.chawan = {
      enable = true;
      settings = {
        buffer = {
          images = true;
        };
        network = {
          allow-http-from-file = true;
        };
      };
    };
  };
}
