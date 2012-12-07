#! /bin/sh
echo 'Copying .vimrc'
cp ~/checkouts/dotfiles/.vimrc ~/.salt-dev/states/dev_vim/files/.vimrc

echo 'Copying .gitconfig'
cp ~/checkouts/dotfiles/.gitconfig ~/.salt-dev/states/dev_git/files/.gitconfig

echo 'Copying .zshrc'
cp ~/checkouts/dotfiles/.zshrc ~/.salt-dev/states/dev_zsh/files/.zshrc
