# -------------------------------------
# エイリアス
# -------------------------------------

# -n 行数表示, -I バイナリファイル無視, svn関係のファイルを無視
alias grep="grep --color -n -I --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"

# 基本コマンドのalias
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
alias sch='vim /Users/tezuka/work/ruby_study/rails_projects/my_conv_app/config/schedule.rb'
alias cronw='cd /Users/tezuka/work/ruby_study/rails_projects/my_conv_app/; bundle exec whenever -w;cd'

# cron 2018/07/13 do [error:temp file must be edited in place]
alias crontab="VIM_CRONTAB=true crontab"

# 環境変数
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export PGDATA=/usr/local/var/postgres
export EDITOR=/usr/bin/vim

# 色設定
export LSCOLORS=gxfxcxdxbxegedabagacad
#export LS_COLORS='di=01;33:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# -------------------------------------
# 便利ファンクション
# -------------------------------------

# cdしたあとで、自動的に ls する
function chpwd() { ls }

# 移動したディレクトリの履歴を取ってくれるzコマンド
. /usr/local/etc/profile.d/z.sh
function _Z_precmd {
    z --add "$(pwd -P)" 61 }
precmd_functions=($precmd_functions _Z_precmd)

# finderで開いている場所をterminalで開く
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

# -------------------------------------
# zshのオプション
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
# プロンプト
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
# キーバインド
# -------------------------------------
bindkey -e

# vimライクな操作を有効化
#bindkey -v

#function cdup() {
#  echo
#  cd ..
#  zle reset-prompt
#}
#
#zle -N cdup
#bindkey '^K' cdup
#
#bindkey "^R" history-incremental-search-backward
#

