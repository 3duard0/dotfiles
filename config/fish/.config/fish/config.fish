set -g theme_display_date no

########################
# Environment Variables
########################
set -gx MUSIC_PATH "$HOME/Music"
set -gx PIP_BIN_PATH "$HOME/.local/bin"

set -gx RBENV "$HOME/.rbenv"
set -gx PATH "$HOME/bin" \
             "$HOME/.cargo/bin" \
             "$HOME/.cabal/bin" \
             "$HOME/.ghcup/bin" \
             "$RBENV/shims" \
             "$PIP_BIN_PATH" \
             $PATH

set -gx EDITOR vim
set -gx ERL_AFLAGS "-kernel shell_history enabled -kernel shell_history_file_bytes 1024000"

########################
# Functions
########################
function download_mp3
   if not test -d $MUSIC_PATH
       echo "Creating music directory: $MUSIC_PATH"
       mkdir $MUSIC_PATH
   end

   youtube-dl -x --audio-format mp3 $argv[1] -o "$MUSIC_PATH/%(title)s.%(ext)s"
end

function fish_greeting
  cowsay -f tux (who)
end

function check_shell_scripts
  find . -type f \( -name '*.sh' -o -name '*.bash' -o -name '*.ksh' -o -name '*.csh' \) -exec 'shellcheck' '--format=gcc' '{}' \;
end

function find_big_files
  find . -type f -exec du -Sh '{}' + | sort -rh | head -n 40
end

function rabbit_start
  docker run -d --name some-rabbit -p 5672:5672 -p 15672:15672 rabbitmq:3-management
end

function rabbit_stop
  docker container stop some-rabbit
  docker container rm -f some-rabbit
end

function cwd
  echo (pwd) > /tmp/my_cwd
end

function cdcwd
  set cwd (/bin/cat /tmp/my_cwd 2>>/dev/null)
  if test -z "$cwd"
      cd "$HOME/devel"
  else
      cd "$cwd"
  end
end


########################
# Aliases
########################
alias ll "ls -alF"
alias la "ls -A"
alias l "ls -CF"
alias emacs "emacsclient -t"
alias et "emacsclient -t"
alias devrails "tmuxinator start rails"
alias cs "check_shell_scripts"
alias i3config "vim $HOME/.config/i3/config"
alias fishconfig "vim $HOME/.config/fish/config.fish"; alias fish_config fishconfig
alias top "htop"
alias bundle1 "bundle _1.17.3_"

########################
# Git
########################

function current_branch
  git rev-parse --abbrev-ref HEAD
end

alias gf "git fetch"
alias gs "git status"

alias ga "git add"
alias gau "git add -u"
alias gaa "git add -A"
alias gap "git add -p"

alias gd "git diff"
alias gds "git diff --stat"
alias gdc "git diff --cached"
alias gdcs "git diff --cached --stat"

alias glg "git graph"
alias gl "git log"
alias gls "git log --stat"
alias glp "git log -p"
alias glps "git log -p --stat"

alias gc "git commit"
alias gcm "git commit -m"
alias gca "git commit --amend"

alias gm "git merge"
alias gmm "git merge origin/master"

alias gr "git rebase"
alias grm "git rebase origin/master"
alias terraform "opentofu.tofu"

function gri
  git rebase -i HEAD~$argv
end

function gcut
  git rebase --onto origin/master $argv (current_branch)
end

alias gp "git push"
alias gpf "git push --force"

function gpu
  git push -u origin (current_branch)
end

# update command
alias gu "git pull"

# branch commands
alias gb "git checkout"
alias gbb "git checkout -b"
alias gbn gbb

# vim
alias vvim vim
alias vim lvim

alias timestamp "date \"+%Y%m%d%H%M%S\""

########################
# Startup commands
########################
cdcwd

source ~/.asdf/asdf.fish
