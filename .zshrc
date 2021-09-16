# -------------------------------------
# alias
# -------------------------------------

# -n 行数表示, -I バイナリファイル無視, svn関係のファイルを無視
alias grep="grep --color -n -I --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"

# base
alias be='bundle exec'
alias ls='ls -G'
alias ll='ls -l'
alias la='ls -a'
alias up='cd ..; ls -l'
alias f='open .'
alias j="z"
alias ctags="`brew --prefix`/bin/ctags"
alias vrc='vim ~/.vimrc'
alias zrc='vim ~/.zshrc'
alias "'brew update'=brew update -v"
alias his='history -30'
alias srd='~/dotfiles/setup_rails_dev.sh'
alias mngd='sudo mongod --dbpath /var/lib/mongodb --logpath /var/log/mongodb.log'

# cron 2018/07/13 do [error:temp file must be edited in place]
alias crontab="VIM_CRONTAB=true crontab"

# env
#export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export PGDATA=/usr/local/var/postgres
export EDITOR=/usr/bin/vim

# color setting
export LSCOLORS=gxfxcxdxbxegedabagacad
#export LS_COLORS='di=01;33:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# -------------------------------------
# function
# -------------------------------------

# cd+ls
function chpwd() { ls }

# z_command (regi move dir history)
#. /usr/local/etc/profile.d/z.sh
#function _Z_precmd {
#    z --add "$(pwd -P)" 61 }
#precmd_functions=($precmd_functions _Z_precmd)

# open terminal to opening finder path
cdf () {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]
      then
        cd "$target"
        pwd
    else
      echo 'No Finder window found' >&2
    fi
}

dic () {
  w3m "http://ejje.weblio.jp/content/$1" | grep "用例"
}

jj () {
    if [ $1 ]; then
        JUMPDIR=$(find . -type d -maxdepth 1 | grep $1 | tail -1)
        if [[ -d $JUMPDIR && -n $JUMPDIR ]]; then
            cd $JUMPDIR
        else
            echo "directory not found"
        fi
    fi
  }

# -------------------------------------
# zsh option
# -------------------------------------

# 自動補完の有効化
autoload -U compinit; compinit

# 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct

# ビープを鳴らさない
setopt nobeep

# 色を使う
setopt prompt_subst

# ^Dでログアウトしない。
setopt ignoreeof

# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt share_history # share command history data

# -------------------------------------
# pronpt
# -------------------------------------

autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least

# begin VCS
zstyle ":vcs_info:*" enable git svn hg bzr
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b|%a]"
zstyle ":vcs_info:(svn|bzr):*" branchformat "%b:r%r"
zstyle ":vcs_info:bzr:*" use-simple true

zstyle ":vcs_info:*" max-exports 6

if is-at-least 4.3.10; then
  zstyle ":vcs_info:git:*" check-for-changes true # commitしていないのをチェック
  zstyle ":vcs_info:git:*" stagedstr "<S>"
  zstyle ":vcs_info:git:*" unstagedstr "<U>"
  zstyle ":vcs_info:git:*" formats "(%b) %c%u"
  zstyle ":vcs_info:git:*" actionformats "(%s)-[%b|%a] %c%u"
fi

function vcs_prompt_info() {
LANG=en_US.UTF-8 vcs_info
[[ -n "$vcs_info_msg_0_" ]] && echo -n " %{$fg[yellow]%}$vcs_info_msg_0_%f"
}

# end VCS
PROMPT=""
PROMPT+="%F{green}%~%f"
PROMPT+="\$(vcs_prompt_info)"
PROMPT+=""

# ディレクトリが長くなるので改行を挿入
PROMPT+="
%% "

RPROMPT="[%*]"

# -------------------------------------
# key bind
# -------------------------------------
#bindkey -v # vimバインド
bindkey -e # vimバインド

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
eval "$(direnv hook zsh)"
