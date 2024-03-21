{ config, pkgs, ... }:
{
  # imports = [
  #   ./git.nix
  # ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jgaines";
  home.homeDirectory = "/home/jgaines";
  
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    bat
    bottom
    direnv
    duf
    dust
    eza
    gh
    git-extras
    magic-wormhole
    neofetch
    nix-direnv
    ripgrep

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # (pkgs.writeShellScriptBin "hm-update" ''
    #   pushd ~/nix > /dev/null
    #   nix flake update
    #   popd > /dev/null
    # '')

    # (pkgs.writeShellScriptBin "hm-switch" ''
    #   pushd ~ > /dev/null
    #   home-manager switch --flake "nix/#$USER"
    #   popd > /dev/null
    # '')

    # (pkgs.writeShellScriptBin "hm-upgrade" ''
    #   hm-update
    #   hm-switch
    # '')

    (pkgs.writeShellScriptBin "hm" ''
      case "$1" in
        update|u)
          nix-channel --update
          ;;
        switch|sw|s)
          home-manager switch
          ;;
        upgrade|up)
          nix-channel --update
          home-manager switch
          ;;
        rollback|rb|r)
          pushd ~ > /dev/null
          home-manager rollback
          popd > /dev/null
          ;;
        generations|gen|g)
          home-manager generations
          ;;
        list|ls|l|packages|p)
          home-manager packages
          ;;
        *)
          echo "Usage: hm [command]"
          echo ""
          echo "Commands:"
          echo "  list|ls|l|packages|p   List all packages managed by Home Manager"
          echo "  generations|gen|g      List all generations of the configuration"
          echo "  switch|sw|s            Switch to the new configuration"
          echo "  rollback|rb|r          Rollback to the previous configuration"
          echo "  upgrade|up             Update the flake and switch to the new configuration"
          echo "  update|u               Update the flake"
          ;;
      esac
    '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jgaines/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "code";
    LOCALE_ARCHIVE = "/usr/lib/locale/locale-archive";
    NIX_SYSTEM = "x86_64-linux";
  };

  home.shellAliases = {
    ls = "eza --color=automatic --git --group-directories-first --icons";
    ll = "ls -l";
    la = "ls -a";
    lla = "ls -la";
    tree = "eza --tree";
    cat = "bat";

    ip = "ip --color";
    ipb = "ip --color --brief";

    # gac = "git add -A  && git commit -a";
    # gp = "git push";
    # gst = "git status -sb";

    htop = "btm -b";

    open = "xdg-open";

    opget = "op item get \"$(op item list --format=json | jq -r '.[].title' | fzf)\"";

    speedtest = "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -";

    pkgfiles = "dpkg -L";
    whichpkg = "dpkg -S";
    gtree = "git gtree";
    g10 = "git gtree -10";
    g20 = "git gtree -20";
    g30 = "git gtree -30";
    g40 = "git gtree -40";
    g50 = "git gtree -50";

    df = "df -kh";
    du = "du -kh";

    nix = "noglob nix";
  };

  programs.command-not-found = {
    enable = true;
    # This and setting NIX_SYSTEM above seem to be necessary to get the command-not-found
    # package to work properly.
    dbPath = "/nix/store/skl6l0k9vc9rpmmr92slxbql1a7cplmr-nixos-23.11-23.11/nixos-23.11/programs.sqlite";
  };

  programs.direnv.enable = true;

  programs.git = {
    enable = true;

    userEmail = "me@jgaines.com";
    userName = "John Gaines";

    # When the working directory is under ~/code/canonical then sign-off commits
    # with Canonical email address.
    # includes = [{
    #   condition = "gitdir:~/code/canonical/";
    #   contents.user.email = "jon.seager@canonical.com";
    # }];

    aliases = {
      a = "add";
      amend = "commit --amend";
      b = "branch -v";
      br = "branch";
      ca = "commit -am";
      c = "commit -m";
      # changelog = log --pretty=format:\" * %s\";
      # changes = log --pretty=format:\"%h %cr %cn %Cgreen%s%Creset\" --name-status
      chunkyadd = "add --patch";
      ci = "commit";
      co = "checkout";
      comm = "commit";
      cp = "cherry-pick -x";
      dc = "diff --cached";
      d = "diff";
      dl = "diff HEAD^";
      dump = "cat-file -p";
      filelog = "log -u";
      hist = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
      last = "log -1 HEAD";
      l = "log --graph --date=short";
      mt = "mergetool";
      pl = "pull";
      ps = "push";
      rc = "rebase --continue";
      r = "remote -v";
      rs = "rebase --skip";
      sa = "stash apply";
      sd = "stash drop";
      short = "log --pretty=format:'%h %cr %cn %Cgreen%s%Creset'";
      shortnocolor = "log --pretty=format:'%h %cr %cn %s'";
      sl = "stash list";
      ss = "stash";
      # s = "status";
      # stat = "status";
      st = "status";
      t = "tag -n";
      type = "cat-file -t";
      uncommit = "reset --soft HEAD^";
      unstage = "reset HEAD --";
      visual = "!gitk &";
      apull = "pull --rebase-merges";
      amerge = "merge --ff-only";
      post = "!rbt post -sog --target-groups eng-tools";
      repost = "!rbt post -r";
      close = "!rbt close --close-type submitted --description \"Committed as $(git log -1 --abbrev-commit --pretty=oneline)\"";
      graph = "log --graph --oneline --decorate=short";
      tree = "log --pretty='format:%w(120,0,24)%>|(24)%cd %C(auto)%d %s (%cn)' --date='format:%F %H:%M' --graph --branches --remotes";
      gtree = "log --graph --branches --remotes --date='format:%F %H:%M' --pretty='format:%w(120,0,24)%C(auto)%cd %h%d %s (%cn)'";
      gtree-old = "log --graph --oneline --decorate=short --branches --remotes";
      fixdiff = "rbt patch -R 57565 post --diff-only -r";
      empty = "commit --allow-empty -m 'Empty commit'";
      who = "!git-who";
      bp = "big-picture";
      ds = "diff --staged";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };

    ignores = [
      "__pycache__/"
      ".cache/"
      ".coverage"
      ".envrc"
      ".idea/"
      ".mise.toml"
      ".mypy_cache/"
      ".pytest_cache/"
      ".rtx.toml"
      ".venv/"
      ".vscode/"
      "*.code-workspace"
      "*.py[co]"
      "*~"
      "junk/"
      "steff/"
      "tags"
      "TAGS"
    ];

    extraConfig = {
      branch = {
        sort = "-committerdate";
      };
      # commit = {
      #   gpgSign = true;
      # };
      # gpg = {
      #   format = "ssh";
      #   ssh = {
      #     defaultKeyCommand = "sh -c 'echo key::$(ssh-add -L | head -n1)'";
      #     allowedSignersFile = "~/.config/git/allowed_signers";
      #   };
      # };
      init = {
        defaultBranch = "master";
      };
      push = {
        default = "matching";
      };
      pull = {
        rebase = true;
      };
      # tag = {
      #   gpgSign = true;
      # };
    };
  };

# Let Home Manager install and manage itself.
programs.home-manager.enable = true;

programs.starship.enable = true;

programs.thefuck.enable = true;

programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.extended = true;
  };
  # environment.pathsToLink = [ "/share/zsh" ];

}
