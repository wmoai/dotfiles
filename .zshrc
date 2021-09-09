alias ll='ls -lG'
alias tailf='tail -f'
alias tmux='tmux -u'

setopt nonomatch

autoload -U compinit
compinit

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' formats '[%s][* %F{green}%b%f]:'
zstyle ':vcs_info:*' actionformats '[%s][* %F{green}%b%f(%F{red}%a%f)]:'
precmd() { vcs_info }
PROMPT='${vcs_info_msg_0_}%F{6}%~/ %f
%F{red}$%f '

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

[ -f ~/.zshrc.local ] && source ~/.zshrc.local


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
