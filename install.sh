#!/usr/bin/env bash

basedir="$(dirname $(readlink -f $0))"
source ${basedir}/config

eval $lines
echo "Making sure $HOME/bin exist.."
mkdir -p $HOME/bin

if [[ ! $(echo $PATH | grep $HOME/bin) ]]; then
  case $SHELL in
    /usr/bin/bash)
      myrc="$HOME/.bashrc"
      echo "export PATH=$PATH:$HOME/bin" >> "$myrc"
      ;;
    /usr/bin/zsh)
      myrc="$HOME/.zshrc"
      echo "export PATH=$PATH:$HOME/bin" >> "$myrc"
      ;;
    /usr/bin/fish)
      myrc="$HOME/.config/fish/config.fish"
      echo "set PATH $PATH $HOME/bin" >> "$myrc"
      ;;
    *) echo "Unknown shell. Please manually add $HOME/bin to your PATH." ;;
  esac
  source "$myrc"
fi

eval $lines
echo "Installing mp3downloader into $HOME/bin.."
ln -s ${basedir}/mp3downloader $HOME/bin/

eval $lines
echo "Installation done. Enjoy!"

exit 0
