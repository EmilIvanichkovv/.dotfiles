{
  config,
  pkgs,
  lib,
  ...
}: {
  # Symlink `functions` folder, but not the whole `fish` directory, as it
  # contains files generated by both Nix and Fish:
  xdg.configFile."fish/functions".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.sessionVariables.CFG}/.config/fish/functions";

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "foreign-env";
        src = pkgs.fishPlugins.foreign-env.src;
      }
      {
        name = "fish-theme-bobthefish";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "theme-bobthefish";
          rev = "76cac812064fa749ffc258a20398c6f6250860c5";
          hash = "sha256-7nZ25R75WsSPqSmyeJbRQ49cITxL3D5CfyplsixFlY8=";
        };
      }
    ];

    shellInit = lib.optionalString pkgs.stdenv.isDarwin ''
      source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    '';

    interactiveShellInit = ''
      # bobthefish theme settings:
      set -g theme_newline_cursor yes
      set -g theme_date_format "+%H:%M:%S %F (%a)"
      set -g theme_color_scheme dark
      set -g theme_display_vi yes
      set -g theme_display_nix yes
      set -g theme_use_abbreviated_branch_name no
      set -g theme_display_git_master_branch yes
      set -g theme_prompt_prefix   '╭─'
      set -g theme_newline_prompt ' ╰─➤ '

      function bobthefish_colors -S -d 'Define a custom bobthefish color scheme'

        # then override everything you want! note that these must be defined with `set -x`
        set -x color_initial_segment_exit     ff5733 ce000f --bold
        set -x color_initial_segment_private  ffffff 255e87
        set -x color_initial_segment_su       ffffff 189303 --bold
        set -x color_initial_segment_jobs     ffffff 255e87 --bold
        set -x color_path                     FF7400 404040 --bold
        set -x color_path_basename            FF7400 000000 --bold
        set -x color_path_nowrite             660000 cc9999
        set -x color_path_nowrite_basename    660000 cc9999 --bold
        set -x color_repo                     009999 ffffff --bold
        set -x color_repo_work_tree           333333 ffffff --bold
        set -x color_repo_dirty               ce000f ffffff
        set -x color_repo_staged              f6b117 3a2a03
        set -x color_vi_mode_default          999999 333333 --bold
        set -x color_vi_mode_insert           189303 333333 --bold
        set -x color_vi_mode_visual           f6b117 3a2a03 --bold
        set -x color_vagrant                  48b4fb ffffff --bold
        set -x color_aws_vault
        set -x color_aws_vault_expired
        set -x color_username                 cccccc 255e87 --bold
        set -x color_hostname                 cccccc 255e87
        set -x color_rvm                      af0000 cccccc --bold
        set -x color_virtualfish              005faf cccccc --bold
        set -x color_virtualgo                005faf cccccc --bold
        set -x color_desk                     005faf cccccc --bold
        set -x color_nix                      005faf cccccc --bold
      end

      function prompt_status -d "the symbols for a non zero exit status, root and background jobs"
        if [ $RETVAL -ne 0 ]
          prompt_segment $color_status_nonzero_bg $color_status_nonzero_str "✘"
        end

        if [ "$fish_private_mode" ]
          prompt_segment $color_status_private_bg $color_status_private_str "🔒"
        end

        # if superuser (uid == 0)
        set -l uid (id -u $USER)
        if [ $uid -eq 0 ]
          prompt_segment $color_status_superuser_bg $color_status_superuser_str "⚡"
        end

        # Jobs display
        if [ (jobs -l | wc -l) -gt 0 ]
          prompt_segment $color_status_jobs_bg $color_status_jobs_str "⚙"
        end
      end

    '';

    shellAbbrs = {
      # Basic
      l = "ls -lah";
      p = "pushd";
      po = "popd";

      # Direnv
      dea = "direnv allow .";
      ded = "direnv deny .";
      der = "direnv reload";

      # Git
      gs = "git status";

      gsh = "git show";
      gshr = "git show --color-words=\"[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+\"";

      gd = "git diff";
      gdr = "git diff --color-words=\"[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+\"";

      gdc = "git diff --staged";
      gdcr = "git diff --staged --color-words=\"[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+\"";

      ga = "git add";
      gap = "git add -p";
      gau = "git add -u";
      gai = "git add --intent-to-add";

      gcm = "git commit -m";
      gcma = "git commit --amend --no-edit";

      gpu = "git pull";

      gps = "git push -u (git-default-remote) HEAD";
      gpf = "git push --force";

      gco = "git checkout";
      gcb = "git checkout -b";

      gstaki = "git stash --keep-index --include-untracked";

      gspo = "git stash pop";
      gspu = "git stash --include-untracked; and git status";

      gbr = "git branch -a";

      glg = "git log";
      gl = "git lg";

      grb = "git rebase";
      grbc = "git rebase --continue";
      grbi = "git rebase -i";

      gchp = "git cherry-pick";
      gchpc = "git cherry-pick --continue";

      # Google Chrome aliases:
      igchr = "google-chrome --incognito & disown";
    };
  };
}
