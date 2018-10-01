#
# ~/.bashrc
#
# export VISUAL=nvim

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

cgroupfs-mount

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
export PATH="$HOME/.rbenv/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/cobalt/.nyan/google-cloud-sdk/path.bash.inc' ]; then source '/home/cobalt/.nyan/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/cobalt/.nyan/google-cloud-sdk/completion.bash.inc' ]; then source '/home/cobalt/.nyan/google-cloud-sdk/completion.bash.inc'; fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
