if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi;

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
if [ -f ~/.profile ]; then
    source ~/.profile
fi;

if [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH";
  eval "$(rbenv init -)";
fi;
