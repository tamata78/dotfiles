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

# -------------------------------------
# パス
# -------------------------------------

# 重複する要素を自動的に削除
typeset -U path cdpath fpath manpath

export PATH=/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/opt/local/bin:/opt/local/sbin:~/bin
export PATH="/usr/local/heroku/bin:$PATH"

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

eval "$(rbenv init -)"
