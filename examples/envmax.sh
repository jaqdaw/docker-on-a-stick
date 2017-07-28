#! /bin/bash
tmux new-session -d 'vim'
tmux new-window 'nano'
tmux new-window 'htop'
tmux new-window 'mc'
tmux new-window 'mutt'
tmux new-window 'w3m www.google.co.uk'
tmux new-window 'bash'
tmux -2 attach-session -d
