''

# vi bindings for pane resizing
bind -r H resize-pane -L 2
bind -r J resize-pane -D 2
bind -r K resize-pane -U 2
bind -r L resize-pane -R 2

set -g status-style 'bg=colour8 fg=colour0 dim'
set -g status-left-length 30
set -g status-justify centre
set -g status-left '#[fg=colour9,bg=colour0]«#I›#[fg=colour8] #H #[fg=colour8,bg=colour0]░▒#[fg=colour8,bg=colour0]░'
set -g status-right-length "100"
set -g status-right '░▒#[fg=colour8,bg=colour0]░  %a %B %-d, %Y'
set -g pane-border-style 'fg=colour3 bg=colour0'
set -g pane-active-border-style 'bg=colour0 fg=colour9'
set -g window-status-format '#[fg=colour8,bg=colour0]░ #W #F ░'
set -g window-status-separator "▒"
setw -g window-status-current-style 'fg=colour1 bg=colour0 bold'
setw -g window-status-current-format '░ #W #F ░'

setw -g monitor-activity on
set -g visual-activity on
tmux_conf_theme_window_status_format='#I #W#{?window_bell_flag,🔔,}#{?window_zoomed_flag,🔍,}'

''
