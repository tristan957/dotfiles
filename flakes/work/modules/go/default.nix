{
  # proxy.golang.org is DNS-sinkholed on Amazon corp networks; fetch directly from VCS.
  programs.go.env = {
    GOPROXY = "direct";
    GONOSUMDB = "*";
  };
}
