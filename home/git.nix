_: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "tetraxile@proton.me";
        name = "tetraxile";
        signingKey = "AB1243FD5015BF6A";
      };

      credential.helper = "cache";
      commit.gpgsign = true;
      tag.gpgsign = true;
      url."https://".insteadof = "git://";
      init.defaultBranch = "main";
      http.sslVerify = false;
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };
}
