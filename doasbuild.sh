#! /bin/bash
mkdir ~/doasbuild
mkdir ~/doasbuild/bash
mkdir ~/doasbuild/codebase
mkdir ~/doasbuild/mutt
mkdir ~/doasbuild/script
mkdir ~/doasbuild/ssh
mkdir ~/doasbuild/tmux
mkdir ~/doasbuild/vim

# bash config
cp ~/.bash_profile ~/doasbuild/bash
cp ~/.bashrc ~/doasbuild/bash
cp ~/.profile ~/doasbuild/bash

# app data
cp -fr ~/.mutt/* ~/doasbuild/mutt/
cp -fr ~/.ssh/* ~/doasbuild/ssh/
cp -fr ~/.tmux/* ~/doasbuild/tmux/
cp -fr ~/.vim/* ~/doasbuild/vim/

# script files
cp -fr ~/script/* ~/doasbuild/script/

# source files
cp -fr ~/codebase/* ~/doasbuild/codebase/
