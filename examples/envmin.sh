#! /bin/bash
tmux new-session -d 'vim'
tmux new-window 'bash'
tmux -2 attach-session -d
