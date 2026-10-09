{...}: {
  config = {
    programs.zoxide = {
      enable = true;
    };

    home.sessionVariables = {
      _ZO_ECHO = "1";
    };
  };
}
