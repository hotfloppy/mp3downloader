#!/usr/bin/env bash

basedir="$(dirname $(readlink -f $0))"
source ${basedir}/config

eval $lines
echo "Checking all dependencies.."
if [[ ! $(ffmpeg -version 2>/dev/null >/dev/null) ]]; then
  echo -e "${green}[+]${nc} ffmpeg"
else
  echo -e "${red}[x]${nc} ffmpeg"
  echo "ffmpeg not found. Please install and rerun install.sh"
  exit 99
fi
echo

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
fi
echo ".. Excellent!"
echo

eval $lines
echo "Installing mp3downloader into $HOME/bin.."
ln -s ${basedir}/mp3downloader $HOME/bin/
echo ".. Done!"
echo

eval $lines
echo -e "${green}NOTES: ${yellow}Restart your terminal, or run this command: source $myrc ${nc}"
echo

eval $lines
echo "Installation done. Enjoy!"
echo

exit 0
