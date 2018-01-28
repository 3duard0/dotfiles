# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

set -g theme_display_date no
function fish_greeting
  cowsay (who)
end

set PATH "$HOME/bin" $PATH
set -x EDITOR vim

# some aliases
alias ll "ls -alF"
alias la "ls -A"
alias l "ls -CF"
alias emacs "emacsclient -t"
alias et "emacsclient -t"
