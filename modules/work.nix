{...}: {
  home.sessionPath = [
    "$HOME/.aim/mcp-servers"
    "$HOME/.toolbox/bin"
  ];

  home.file.".local/bin/mcurl" = {
    source = ../work/.local/bin/mcurl;
    executable = true;
  };
}
