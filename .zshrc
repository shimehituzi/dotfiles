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
export PATH=$(stack path --local-bin):$PATH
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
eval "$(stack --bash-completion-script stack)"
export PATH="/usr/local/opt/llvm/bin:$PATH"
eval "$(hub alias -s)"

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


# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/shimehituzi/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# 自分好みの関数
dopr() {
  if [ $# != 1 ]; then
    echo "引数が必要ですブランチ名を指定してください．"
    return 1
  fi
  while :
  do
    read "DATA1?$(basename $(pwd)) に対してプルリクエストを作成しますか？ (yes/no): "
    if [ "$DATA1" = "yes" ]; then
      break
    elif [ "$DATA1" = "no" ]; then
      echo "中止しました"
      return 1
    else
      echo "yes か no と入力してください"
    fi
  done
  while :
  do
    read  "DATA2?ブランチ $1 を作成し $1 から master に対するプルリクエストを作成しますか？ (yes/no): "
    if [ "$DATA2" = "yes" ]; then
      git checkout -b $1
      git commit --allow-empty -m "init $1 branch"
      git push origin $1
      git pull-request -b "master"
      return 0
    elif [ "$DATA2" = "no" ]; then
      echo "中止しました"
      return 1
    else
      echo "yes か no と入力してください"
    fi
  done
}

prdone() {
  REPO=$(git rev-parse --abbrev-ref HEAD)
  while :
  do
    read "DATA1?$ master を pull してブランチ $REPO を削除しますか  (yes/no): "
    if [ "$DATA1" = "yes" ]; then
      git checkout master
      git pull
      git branch -d $REPO
      return 0
    elif [ "$DATA1" = "no" ]; then
      echo "中止しました"
      return 1
    else
      echo "yes か no と入力してください"
    fi
  done
}

# 自分好みのエイリアス
alias nv='(){nvim -c "cd $1"}'
alias ns='nvim -c "cd src"'
alias mc='(){mkdir $1 && cd $1}'
alias relogin='exec $SHELL -l'
alias gpo='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gbcp='(){git branch $1 && git checkout $1 && git push origin $1}'
alias gcpd='(){git checkout master && git pull && git branch -d $1}'
alias jss='(){json-server -p 3001 -w $1}'
alias hb="stack build"
alias h="stack exec ${PWD##*/}-exe"
alias hh="hb && clear && echo '--- stack exec ---\n\n' && h"
alias ghci="stack ghci"
alias runghc="stack runghc -- -isrc app/Main.hs"
alias gphm="git push heroku master"
alias rt='rmtrash'
alias lar='ls -aR'
alias sds='find . -name .DS_Store'
alias sagh="ssh-add -K ~/.ssh/id_rsa_github"
alias invim="cd ~/.config/nvim/;nvim *.vim *.toml *.json colors/*.vim"
alias zshrc="nvim ~/.zshrc ~/Dropbox/dotfiles/.zshrc"
alias tmks="tmux kill-server"
alias cdd="cd ~/Dropbox"
alias ra="bin/rails"
alias be="bundle exec"
alias rs2="bin/rails s -p 3001"
alias rmds="\\rm -v .DS_Store;echo"
alias nvimtex="pyenv shell neovim3;NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim"
alias reinstalldeinplugins="cd ~/.cache;\rm -rf dein/;cd ~/;sh ~/.cache/dein_installer.sh ~/.cache/dein;nvim ~/.config/nvim/*.vim ~/.config/nvim/*.toml"
alias pry="bundle exec pry --simple-prompt"
alias startpg="brew services start postgresql"
alias stoppg="brew services stop postgresql"
alias rm="echo 'use rt command!'"
alias ch='open -n -a "Google Chrome" --args -incognito'

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
alias work=""
