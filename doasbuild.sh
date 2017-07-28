#! /bin/bash
set -x

mkdir -p ~/doasbuild/{bash,codebase,mutt,script,ssh,tmux,vim}

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
