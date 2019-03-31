set -g theme_display_date no

########################
# Environment Variables
########################
set -gx MUSIC_PATH "$HOME/Music"
set -gx PIP_BIN_PATH "$HOME/.local/bin"

set -gx GOBIN "$HOME/Programs/go/bin"
set -gx GOPATH "$HOME/dev/go"
set -gx RBENV "$HOME/.rbenv"
set -gx NODE_PATH "$HOME/Programs/node-v10.11.0-linux-x64"
set -gx PATH "$HOME/bin" \
             "$RBENV/shims" "$NODE_PATH/bin" "$PIP_BIN_PATH" \
             "$GOPATH" "$GOBIN" \
             $PATH

set -gx EDITOR vim

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

########################
# Aliases
########################
alias ll "ls -alF"
alias la "ls -A"
alias l "ls -CF"
alias emacs "emacsclient -t"
alias et "emacsclient -t"
alias devrails "tmuxinator start rails"
alias cat "bat"
alias cs "check_shell_scripts"
alias i3config "vim $HOME/.config/i3/config"
alias fishconfig "vim $HOME/.config/fish/config.fish"; alias fish_config fishconfig

########################
# Startup commands
########################
/bin/cat ~/.cache/wal/sequences &
