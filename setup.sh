#!/usr/bin/env bash

######################################### bash
cd ~
rm ~/.bashrc
ln -s ~/dotfiles/.bashrc ~/

######################################### tmux setup
cd ~
rm ~/.tmux.conf
rm ~/.tmux
ln -s ~/dotfiles/.tmux.conf ~/
ln -s ~/dotfiles/.tmux ~/

######################################### fzf
cd ~/dotfiles
mkdir 3rdparty
cd 3rdparty
git clone https://github.com/junegunn/fzf.git
cd fzf
./install --bin --64

######################################### vim setup
cd ~
rm ~/.vimrc
rm ~/.vim
ln -s ~/dotfiles/.vimrc ~/
ln -s ~/dotfiles/.vim ~/
# bundle
cd ~/.vim/bundle/
if [ -e Vundle.vim ]; then
  cd Vundle.vim
  git pull
else
  git clone http://github.com/VundleVim/Vundle.vim.git
fi
cd ~/dotfiles
vim
# compile and install YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe/
./install.sh --clang-completer --quiet
cd ~/dotfiles
