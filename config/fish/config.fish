if test -e ~/.env
  source ~/.env
end
if test -e ~/.asdf/asdf.fish
  source ~/.asdf/asdf.fish
end
if test -e /opt/homebrew/lib/asdf.fish
  source /opt/homebrew/lib/asdf.fish
end
alias arduino=/Applications/Arduino.app/Contents/MacOS/Arduino

set PATH $PATH ./bin
set PATH $PATH /usr/local/bin
set PATH $PATH /opt/homebrew/bin
set PATH $PATH /usr/local/google-cloud-sdk/bin

set PATH /Users/sdavis/go/bin $PATH

# nice light cyan color instead of dark blue
set -gx LSCOLORS gxfxcxdxbxegedabagacad

function ls --description 'List contents of directory'
  command ls -lhFG $argv
end

function df --description 'Displays disk free space'
  command df -H $argv
end

function grep --description 'Colorful grep that ignores binary file and outputs line number'
  command grep --color=always -I $argv
end

function gg --description 'git grep with color'
  command git grep -n --color $argv
end

function git-replace --description "replace all in repo"
  set replace $argv[1];
  set to_replace $argv[2];
  switch (uname)
    case Linux
      command git grep -l $replace | xargs sed -i '' "s/$replace/$to_replace/g"
    case Darwin
      command git grep -l $replace | xargs sed -i '' -e "s/$replace/$to_replace/g"
  end
end

function gf --description 'Do a git fetch'
  command git fetch
end

function gs --description 'Do a git status'
  command git status
end

function gdeletemergedcurrent --description 'Delete all local branches that is already merged to current branch (exludes master)'
  command git branch --merged | grep -v "\*" | grep -v "master" | xargs -n 1 git branch -d
  command git remote prune origin
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

if test -e /opt/homebrew/bin/direnv
  direnv hook fish | source;
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sdavis/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/sdavis/Downloads/google-cloud-sdk/path.fish.inc'; end
