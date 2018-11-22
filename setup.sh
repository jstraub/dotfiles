#!/usr/bin/env bash

sudo dnf install silversearcher-ag vim tmux
sudo apt install silversearcher-ag vim tmux cmake 
curl https://sh.rustup.rs -sSf | sh

if [ ! -e ~/dotfiles/3rdparty ]; then
  mkdir ~/dotfiles/3rdparty
fi
mkdir ~/.logs/

######################################### alacritty
if [ ! -e ~/dotfiles/3rdparty/alacritty ]; then
  cd ~/dotfiles/3rdparty
  git clone https://github.com/jwilm/alacritty.git
else
  cd ~/dotfiles/3rdparty/alacritty
  git pull
fi 
cd ~/dotfiles/3rdparty/alacritty
cargo install cargo-deb
cargo deb --install

######################################### bash
cd ~
rm ~/.bashrc
ln -s ~/dotfiles/.bashrc ~/

######################################### tmux setup

if [ ! -e ~/dotfiles/3rdparty/tmuxinator ]; then
  cd ~/dotfiles/3rdparty
  git clone https://github.com/tmuxinator/tmuxinator.git
else
  cd ~/dotfiles/3rdparty/tmuxinator
  git pull
fi
cd ~/dotfiles/3rdparty/tmuxinator
sudo gem install tmuxinator

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
mkdir ~/.vim/bundle/
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
