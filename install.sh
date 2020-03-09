#!/usr/bin/env bash

basedir="$(dirname $(readlink -f $0))"
source ${basedir}/config

eval $lines
echo "Making sure $HOME/bin exist.."
mkdir -p $HOME/bin

eval $lines
echo "Installing mp3downloader into $HOME/bin.."
ln -s ${basedir}/mp3downloader $HOME/bin/

eval $lines
echo "Installation done. Enjoy!"

exit 0
