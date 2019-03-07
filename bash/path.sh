# Add useful directories into PATH
# echo $PATH
if [[ $PATH != *"$HOME/.bin"* ]]; then # prevent souble PATH concatenation
  for __DIR in .{npm-global,nimble,cargo}/bin Android/Sdk/{platform-,}tools; do
    [[ -d $HOME/$__DIR ]] && PATH=$HOME/$__DIR:$PATH
  done

  # some distros don't include sbin
  [[ $PATH != */usr/sbin* ]] && PATH+=:/usr/sbin

  # ~/.bin and .local/bin - for user specific environment and startup programs
  # PATH=$PATH:$HOME/.local/bin:$HOME/.bin
  # not safe but allows overriding
  PATH=$HOME/.local/bin:$HOME/.bin:$PATH

  # Mac
  if [[ -d /usr/local/opt/coreutils/libexec/gnubin ]]; then
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
  fi
  if [[ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]]; then
    PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  fi
  if [[ -d "$HOME/Library/Python/3.7/bin" ]]; then
    PATH="$HOME/Library/Python/3.7/bin:$PATH"
  fi
fi
