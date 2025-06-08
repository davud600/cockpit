#
# ~/.bashrc
#

export PATH="$HOME/.local/bin:$PATH"
export TERM=tmux-256color
export TERMINFO=$HOME/.terminfo

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PATH="$PATH:/home/davud/.npm-global/bin"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Created by `pipx` on 2025-05-09 15:56:41
export PATH="$PATH:/home/davud/.local/bin"
export PATH=$PATH:/home/davud/.local/bin

# Android sdk
export ANDROID_HOME="/opt/android-sdk"
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/davud/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/davud/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/davud/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/davud/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

# tmux
# if [ -z "$TMUX" ] && [ -z "$SSH_TTY" ]; then
#    tmux attach-session -t default || tmux new-session -s default
# fi

# .dotfiles
alias cockpit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
