# https://blog.gitbutler.com/how-git-core-devs-configure-git/

{pkgs, ...}: {
  programs.git-credential-oauth.enable = true;
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
      rebase.autosquash = true;

      push.autoSetupRemote = true;

      commit.gpgsign = true;
      commit.verbose = true;

      merge.conflictstyle = "zdiff3";
      diff.colorMoved = true;
      diff.algorithm = "histogram";
      feature.experimental = true;
      branch.sort = "committerdate";
      diff.mnemonicPrefix = true;
      fetch.all = true;
      column.ui = "auto";
      tags.sort = "version:refname";
      push.followTags = true;

      rerere.enabled = true;
      rerere.autoupdate = true;

      rebase.updateRefs = true;




      gpg.format = "ssh";
      # credential.helper = "oauth";
      credential = {
        "https://git.yadunut.dev" = {
          oauthClientId = "a4792ccc-144e-407e-86c9-5e7d8d9c3269";
          oauthScopes = "read:repository write:repository";
          oauthAuthURL = "/login/oauth/authorize";
          oauthTokenURL = "/login/oauth/access_token";
        };
      };
    };
  };
  home.packages = [
    pkgs.delta
  ];
}
