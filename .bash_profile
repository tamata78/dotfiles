# ls coloring
export LSCOLORS=gxfxcxdxbxegedabagacad

# -------------------------------------
# エイリアス
# -------------------------------------

# -n 行数表示, -I バイナリファイル無視, svn関係のファイルを無視
alias grep="grep --color -n -I --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"

# 基本コマンドのalias
alias ls='ls -G'
alias ll='ls -l'
alias la='ls -a'
alias up='cd ..; ls -l'
alias j="z"
alias vrc='vim ~/.vimrc'
alias brc='vim ~/.bashrc'

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[ -r $HOME/.bashrc ] && source $HOME/.bashrc
