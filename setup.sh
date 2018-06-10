#!/usr/bin/env bash

sudo apt install silversearcher-ag vim tmux cargo cmake 
if [ ! -e ~/dotfiles/3rdparty ]; then
  mkdir ~/dotfiles/3rdparty
fi
mkdir ~/.logs/

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

######################################### fd (find replacement)

if [ ! -e ~/dotfiles/3rdparty/fd ]; then
  cd ~/dotfiles/3rdparty
  git clone https://github.com/sharkdp/fd.git
else
  cd ~/dotfiles/3rdparty/fd
  git pull
fi
cd ~/dotfiles/3rdparty/fd
cargo install

######################################### fzf
if [ ! -e ~/dotfiles/3rdparty/fzf ]; then
  cd ~/dotfiles/3rdparty
  git clone https://github.com/junegunn/fzf.git
else
  cd ~/dotfiles/3rdparty/fzf
  git pull
fi 
cd ~/dotfiles/3rdparty/fzf
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
