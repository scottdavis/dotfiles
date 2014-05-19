export TERM=xterm-256color
export EDITOR='vim'
source ~/dotfiles/aliases
source ~/dotfiles/completions
#source ~/.bash/config

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

if [ -f ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi

source ~/dotfiles/basic

#rvm include
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
#screenenator include
if [[ -s $HOME/.screeninator/scripts/screeninator ]] ; then source $HOME/.screeninator/scripts/screeninator ; fi

source ~/dotfiles/paths

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
