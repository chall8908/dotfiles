bind - split-window -v -c "#{pane_current_path}"
bind | split-window -h -c "#{pane_current_path}"
bind _ new-window -c "#{pane_current_path}"
bind % new-session -c "#{pane_current_path}"
unbind-key -n C-s
unbind-key -n C-a
set -g prefix ^A
set -g prefix2 F12
bind a send-prefix
