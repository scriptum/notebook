# open any file from terminal with suitable application
if hash xdg-open 2>/dev/null; then
  o(){
    if [[ $# -eq 0 ]]; then
      xdg-open "$(L)" 2> /dev/null
    else
      xdg-open "$@" 2> /dev/null
    fi
  }
  elif hash exo-open 2>/dev/null; then
  o(){
    if [[ $# -eq 0 ]]; then
      exo-open "$(tmux capture-pane -p | tail -3 | head -1)" 2> /dev/null
    else
      exo-open "$@" 2> /dev/null
    fi
  }
fi
