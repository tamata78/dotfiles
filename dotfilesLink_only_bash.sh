#!/bin/bash

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".zprofile" ]] && continue
    [[ "$f" == ".zshrc" ]] && continue
    [[ "$f" == ".enhancd" ]] && continue
    [[ "$f" == ".ssh" ]] && continue
    [[ "$f" == ".viminfo" ]] && continue

    echo "$f"
    ln -sf ~/dotfiles/$f ~/$f
done

# svn alias
#if [ -f ~/win_env_setting/setup/setting_svn_conf.sh ] ; then
#    . ~/win_env_setting/setup/setting_svn_conf.sh
#fi

