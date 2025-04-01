
source $HOME/.config/fish/functions/my_functions.fish

if test -e ~/.env
  source ~/.env
end

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end

set --erase _asdf_shims

if is_osx
  if test -e /opt/homebrew/opt/asdf/libexec/asdf.fish
    source /opt/homebrew/opt/asdf/libexec/asdf.fish
  end
  if test -e /Applications/Postgres.app/Contents/Versions/latest/bin/pg_config
    fish_add_path /Applications/Postgres.app/Contents/Versions/latest/bin
  end

  if test -e /Applications/Postgres.app/Contents/Versions/14/bin/clusterdb
    fish_add_path /Applications/Postgres.app/Contents/Versions/14/bin
  end

  test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

  fish_add_path /opt/homebrew/opt/curl/bin
  fish_add_path /opt/homebrew/bin
end

# nice light cyan color instead of dark blue
set -gx LSCOLORS gxfxcxdxbxegedabagacad

fish_add_path ./bin
fish_add_path /usr/local/bin
fish_add_path /Users/sdavis/go/bin

if type -q direnv
  direnv hook fish | source;
end
