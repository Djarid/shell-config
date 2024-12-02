
# enable completion
if ! shopt -oq posix; then
  if [ -f /usr/shar/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# enable per session history files
#

# Add timestamps to history entries (or it is not persisted to file)
export HISTTIMEFORMAT="%F %T "

#  Create the .bash_history directory if it doesn't exist
if [[ ! -d "$HOME/.bash_history" ]]; then
  mv "$HOME/.bash_history" "$HOME/.bash_history.orig"
  mkdir "$HOME/.bash_history"
  mv "$HOME/.bash_history.orid" "$HOME/.bash_history/"
fi

# Flush the in memory history on every command
write_history() {
  history -a
  echo "#$(date +%s)" >> "$HOME/.bash_history/master_history"
  history 1 | awk '{for (i=4; i<=NF; i++) {printf "%s", $i} printf "\n"}' >> "$HOME/.bash_history/master_history"
}

# Flush the history to disk and copy to the master history (syncing all sessions)
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}write_history"

# Create a per session bash history file
export HISTFILE="$HOME/.bash_history/bash_history.$$"

# Load history from master file as this session will have an empty history
MASTER_HISTORY="$HOME/.bash_history/master_history"
if [[ -f "$MASTER_HISTORY" ]]; then
  history -r "$MASTER_HISTORY"
fi
