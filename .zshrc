#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export PATH="$HOME/.rbenv/bin:$PATH" 
eval "$(rbenv init - zsh)"
eval "$(direnv hook zsh)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pipenv --completion)"
export PYENV_PATH="$HOME/.pyenv"

# vimでescが押された後のタイムラグを防ぐ
KEYTIMEOUT=1

# cursorの形状をmodeによって変える
zle-keymap-select () {
if [ $KEYMAP = vicmd ]; then
    printf "\033[2 q"
else
    printf "\033[6 q"
fi
}
zle -N zle-keymap-select
zle-line-init () {
zle -K viins
printf "\033[6 q"
}
zle -N zle-line-init
bindkey -v

# 初回シェル時のみ tmux実行
if [ $SHLVL = 1 ]; then
  tmux
fi

# powerlevel9k
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon battery dir virtualenv vcs status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_CHANGESET_HASH_LENGTH=7
POWERLEVEL9K_VIRTUALENV_BACKGROUND='red'
POWERLEVEL9K_STATUS_OK_BACKGROUND="white"
POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="red"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="white"


# 自分好みのエイリアス
alias sagh="ssh-add -K ~/.ssh/id_rsa_github"
alias rt='rmtrash'
alias invim="cd ~/.config/nvim/;nvim *.vim *.toml"
alias zshrc="nvim ~/.zshrc"
alias cdd="cd ~/Dropbox"
alias nvimtex="pyenv shell neovim3;NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim"
alias be="bundle exec"
alias rmds="\\rm -v .DS_Store;echo"
alias reinstalldeinplugins="cd ~/.cache;\rm -rf dein/;cd ~/;sh ~/.cache/dein_installer.sh ~/.cache/dein;nvim ~/.config/nvim/*.vim ~/.config/nvim/*.toml"
alias pry="bundle exec pry --simple-prompt"
alias startps="brew services start postgresql"
alias stopps="brew services stop postgresql"
alias rm="echo 'use rt command!'"

# macbook用
POWERLEVEL9K_BATTERY_LOW_BACKGROUND='cyan'
POWERLEVEL9K_BATTERY_LOW_FOREGROUND='red'
POWERLEVEL9K_BATTERY_CHARGING_BACKGROUND='cyan'
POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND='black'
POWERLEVEL9K_BATTERY_CHARGED_BACKGROUND='cyan'
POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND='black'
POWERLEVEL9K_BATTERY_DISCONNECTED_BACKGROUND='cyan'
POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND='black'
POWERLEVEL9K_BATTERY_LOW_THRESHOLD=15
POWERLEVEL9K_BATTERY_VERBOSE=false

# 一時的なエイリアス
alias work="echo ''"
