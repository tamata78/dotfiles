alias ga='git add'
alias gap='git add -p'
alias gb='git branch'
alias gcm='git commit -v'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcof='git-checkout-force'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gdm='git-delete-merged'
alias gg='git grep'
alias gl="git log --pretty='%h %ci %s %cn'"
alias gpl='git pull'
alias grb='git rebase'
alias gplr='git pull --rebase'
alias grbi='git rebase -i'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
for n in $(seq 10); do
  alias grbi$n="git rebase -i HEAD~$n"
done
alias grs='git reset'
for n in $(seq 10); do
  alias grs$n="git reset HEAD~$n"
done
alias gst='git status -s && echo --- branch && git branch && echo --- stash && git stash list | cat'
alias gsh='git show'
alias gps='git push'
alias gpsf='git push --force-with-lease --force-if-includes'
alias gtr="log --graph --date=short --pretty='format:%C(yellow)%h%Creset %s %Cgreen(%an)%Creset %Cred%d%Creset'"
alias gfp='git fetch -p'
alias gs='git stash'
alias gsl='git stash list'
alias gsd='git stash drop'
