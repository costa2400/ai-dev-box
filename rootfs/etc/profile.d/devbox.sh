[ -n "$BASH_VERSION" ] || return 0
[ -f /run/devbox.env ] && . /run/devbox.env
eval "$(mise activate bash)"

# (!) Interactive SSH so agents keep running if you disconnect. Opt out: touch ~/.notmux
if [ -n "$SSH_TTY" ] && [ -z "$TMUX" ] && [ ! -e ~/.notmux ]; then
  tmux new -A -s main && exit
fi
