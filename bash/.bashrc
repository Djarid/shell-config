
# enable completion
if ! shopt -oq posix; then
  if [ -f /usr/shar/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Enable consistent bash history across multiple sessions
shopt -S histappend
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history-a; history -c; history -r"

q:q
