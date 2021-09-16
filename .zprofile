# -------------------------------------
# 環境変数
# -------------------------------------

# SSHで接続した先で日本語が使えるようにする
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# エディタ
export EDITOR=/usr/local/bin/vim

# 言語設定
export LANG=ja_JP.UTF-8

# Homebrew cask設定
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# python

# -------------------------------------
# パス
# -------------------------------------

# function path override
export fpath=(/usr/local/share/zsh/site-functions /usr/local/share/zsh/functions)

# 重複する要素を自動的に削除
typeset -U path cdpath fpath manpath

export PATH=/bin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/usr/X11/bin:/opt/local/bin:/opt/local/sbin:~/bin
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="/usr/local/opt/maven2.2.1/bin:$PATH"

path=(
$HOME/bin(N-/)
/usr/local/bin(N-/)
/usr/local/sbin(N-/)
$path
)

# git alias設定
if [ -f ~/dotfiles/git-setup.sh ] ; then
  . ~/dotfiles/git-setup.sh
fi

if [ -f ~/.zshrc ] ; then
  . ~/.zshrc
fi

#eval "$(rbenv init -)"

# pip zsh completion start タブ補完を実現
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end

# improve cd
if [ -f ~/enhancd/init.sh ]; then
    source ~/enhancd/init.sh
fi
