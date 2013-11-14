export TERM=xterm-256color
source ~/dotfiles/aliases
source ~/dotfiles/completions
#source ~/.bash/config

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

source ~/dotfiles/basic

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

source ~/dotfiles/paths
