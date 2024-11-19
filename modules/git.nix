{ pkgs, ... }:
{
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

      push.autoSetupRemote = true;

      commit.gpgsign = true;
      commit.verbose = true;

      gpg.format = "ssh";
      credential = {
        "https://git.yadunut.dev" = {
          oauthClientId = "a4792ccc-144e-407e-86c9-5e7d8d9c3269";
          oauthScopes = "read:repository write:repository";
          oauthAuthURL =  "/login/oauth/authorize";
          oauthTokenURL =  "/login/oauth/access_token";
        };
      };

    };
  };
  home.packages = [
    pkgs.delta
  ];
}
