{config, ...}: {
  config = {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "Tristan Partin";
          email = "tristan@partin.io";
        };
        advice.skippedCherryPicks = false;
        alias = {
          b = "branch";
          c = "commit";
          conflicts = "diff --name-only --diff-filter=U";
          d = "diff";
          dc = "diff --cached";
          dt = "difftool";
          dtc = "difftool --cached";
          l = "log --oneline";
          s = "status";
          lg = "lg1";
          lg1 = "lg1-specific --all";
          lg2 = "lg2-specific --all";
          lg3 = "lg3-specific --all";
          lg1-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
          lg2-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
          lg3-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'";
          message = "log --format=%B -n 1";
          redo = "!git log -n 1 --pretty=tformat:%s%n%n%b | git commit -F - --amend";
          undo = "reset --mixed HEAD^";
          upstream = "rev-parse --abbrev-ref --symbolic-full-name @{upstream}";
          z = "!git branch --format='%(refname:short)' --all | fzf --bind 'enter:become(git switch ''{}'' >/dev/null 2>/dev/null)'";
        };
        branch.sort = "-committerdate";
        color.ui = "auto";
        commit = {
          cleanup = "scissors";
          template = "${./templates/personal}";
          verbose = true;
        };
        core.autocrlf = false;
        credential = {
          "https://github.com".helper = "${./git-credential-op} --account=my.1password.com op://Git/GitHub/credential";
          "smtps://smtp.fastmail.com" = {
            username = "tristan@partin.io";
            helper = "${./git-credential-op} --account=my.1password.com op://Git/Email/password";
          };
        };
        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mnemonicPrefix = true;
          renames = true;
          submodule = "log";
          wsErrorHighlight = "none";
        };
        fetch = {
          all = true;
          prune = true;
          prunetags = true;
        };
        format = {
          commitListFormat = "modern";
          coverFromDescription = "auto";
          coverLetter = "auto";
          notes = true;
          numbered = "auto";
          outputDirectory = "outgoing";
          signOff = true;
          signatureFile = "${./signatures/personal}";
        };
        init.defaultBranch = "master";
        log.date = "iso-local";
        merge = {
          autoStash = true;
          conflictStyle = "zdiff3";
        };
        notes = {
          displayRef = "refs/notes/*";
          rewriteMode = "concatenate";
        };
        protocol.file.allow = "always";
        pull.rebase = true;
        rebase = {
          autosquash = true;
          autoStash = true;
          updateRefs = true;
        };
        remote.origin.fetch = "+refs/notes/*:refs/notes/*";
        rerere = {
          autoUpdate = true;
          enabled = true;
        };
        sendemail = {
          aliasesFile = "${./aliases}";
          aliasFileType = "mutt";
          confirm = "always";
          sendmailCmd = "mjmap";
          smtpEncryption = "ssl";
          smtpServer = "smtp.fastmail.com";
          smtpServerPort = 465;
          smtpUser = "tristan@partin.io";
        };
        status = {
          relativePaths = true;
          submoduleSummary = false;
        };
        tag.sort = "version:refname";
        trailer = {
          link.key = "Link";
          sign.key = "Signed-off-by";
          review.key = "Reviewed-by";
          test.key = "Tested-by";
        };
      };

      signing = {
        key = "CBBFE833EE3249D8EA35D2658F8FFBAF9BD0B0BC";
        format = "openpgp";
        signer = "gpg2";
        signByDefault = false;
      };

      includes = [
        {
          condition = "gitdir:~/Projects/postgres/";
          contents = {
            commit.template = "${./templates/postgres}";
            # Postgres mailing list is unconventional...
            format.coverLetter = false;
          };
        }
      ];

      # https://git-scm.com/docs/gitattributes#_defining_a_custom_hunk_header
      attributes = [
        "*.bash diff=bash"
        "*/.bash_logout diff=bash"
        "*/.bash_profile diff=bash"
        "*/.bashrc diff=bash"
        "*.c diff=cpp"
        "*.cc diff=cpp"
        "*.cpp diff=cpp"
        "*.cs diff=csharp"
        "*.css diff=css"
        "*.go diff=golang"
        "*.h diff=cpp"
        "*.hpp diff=cpp"
        "*.html diff=html"
        "*.java diff=java"
        "*.kt diff=kotlin"
        "*.md diff=markdown"
        "*.pl diff=perl"
        "*.php diff=php"
        "*.py diff=python"
        "*.rb diff=ruby"
        "*.rs diff=rust"
        "*.sh diff=bash"
        "*.xhtml diff=html"
      ];

      ignores = [
        # Cargo
        "/target/"

        # Clangd
        "/.clangd"
        ".cache/clangd/"
        "compile_commands.json"
        "compile_commands.*.json"

        # Claude
        "/.claude/settings.local.json"

        # Compdb
        ".compdb/"

        # Direnv
        "/.direnv/"
        ".envrc"

        # devenv
        "/.devenv/"
        "devenv.local.nix"
        "devenv.local.yaml"

        # Git
        "/outgoing/"

        # JavaScript
        "/node_modules/"

        # macOS
        ".DS_Store"

        # mypy
        "/.mypy_cache/"

        # NFS
        ".nfs*"

        # Python
        "/__pycache__/"

        # Pyright/basedpyright
        "pyrightconfig.json"

        # Ruff
        "/.ruff_cache/"

        # VSCode
        ".vscode/"

        # Zig
        "/.zig-cache/"
        "/zig-out/"
        "/zig-pkg/"
      ];
    };

    home.file."${config.xdg.binHome}/git-user" = config.lib.file.mkExecutable ./git-user;
  };
}
