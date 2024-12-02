# ls coloring
export LSCOLORS=gxfxcxdxbxegedabagacad

# -------------------------------------
# alias
# -------------------------------------

# -n display line num, -I ignore binary file, svn related files
alias grep="grep --color -n -I --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"

# base alias
alias ls='ls -G'
alias ll='ls -l'
alias la='ls -a'
alias up='cd ..; ls -l'
alias vrc='vim ~/.vimrc'
alias brc='vim ~/.bashrc'

[ -r $HOME/.bashrc ] && source $HOME/.bashrc

# git alias
if [ -f ~/dotfiles/git-setup.sh ] ; then
  . ~/dotfiles/git-setup.sh
fi


### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="~/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
