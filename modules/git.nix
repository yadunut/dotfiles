{
  programs.git = {
    enable = true;
    userEmail = "yadunand@yadunut.com";
    userName = "Yadunand Prem";
    delta.enable = true;
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "main";

      pull.rebase = true;
      pull.autostash = true;

      rebase.autostash = true;

      push.autoSetupRemote = true;

      commit.gpgsign = true;
      commit.verbose = true;

      gpg.format = "ssh";
    };
  };
}
