#!/usr/bin/env bash

banner "Vim setup"
files=(vim vimrc)

for v in "${files[@]}"
do
  safe ln -sfb -T $DOTFILE_VIM/$v ~/.$v
done

banner "Install Vundle from Gitee"
safe git clone https://gitee.com/e1iu/Vundle.vim.git $DOTFILE_VIM/vim/bundle/Vundle.vim

banner "Install Vim Plugins"
safe vim +PluginInstall +qall

# fzf/install script will download fzf from https://github.com/junegunn/fzf/releases
banner "Install fzf"
safe bash $DOTFILE_VIM/vim/bundle/fzf/install
