# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
#source $OMF_PATH/init.fish

set -g theme_display_date no

########################
# Environment Variables
########################
set -gx MUSIC_PATH "$HOME/Music"
set -gx GOPATH "$HOME/go"
set -gx PATH "$GOPATH/bin" "$HOME/bin" $PATH
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

########################
# Aliases
########################
alias ll "ls -alF"
alias la "ls -A"
alias l "ls -CF"
alias emacs "emacsclient -t"
alias et "emacsclient -t"
