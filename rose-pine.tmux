#!/usr/bin/env bash
#
# Rosé Pine - tmux theme
#
# Almost done, any bug found file a PR to rose-pine/tmux
# 
# Inspired by dracula/tmux, catppucin/tmux & challenger-deep-theme/tmux
#
#
export TMUX_ROSEPINE_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"

get_tmux_option() {
    local option value default
    option="$1"
    default="$2"
    value="$(tmux show-option -gqv "$option")"
    
    if [ -n "$value" ]; then
        echo "$value"
    else
        echo "$default"
    fi
}

set() {
    local option=$1
    local value=$2
    tmux_commands+=(set-option -gq "$option" "$value" ";")
}

setw() {
    local option=$1
    local value=$2
    tmux_commands+=(set-window-option -gq "$option" "$value" ";")
}


main() {
    local theme
    theme="$(get_tmux_option "@rose_pine_variant" "")"

    if [[ $theme == main ]]; then

        thm_base="#191724";
        thm_surface="#1f1d2e";
        thm_overlay="#26233a";
        thm_muted="#6e6a86";
        thm_subtle="#908caa";
        thm_text="#e0def4";
        thm_love="#eb6f92";
        thm_gold="#f6c177";
        thm_rose="#ebbcba";
        thm_pine="#31748f";
        thm_foam="#9ccfd8";
        thm_iris="#c4a7e7";
        thm_hl_low="#21202e";
        thm_hl_med="#403d52";
        thm_hl_high="#524f67";

    elif [[ $theme == dawn ]]; then

        thm_base="#faf4ed";
        thm_surface="#fffaf3";
        thm_overlay="#f2e9e1";
        thm_muted="#9893a5";
        thm_subtle="#797593";
        thm_text="#575279";
        thm_love="#b4367a";
        thm_gold="#ea9d34";
        thm_rose="#d7827e";
        thm_pine="#286983";
        thm_foam="#56949f";
        thm_iris="#907aa9";
        thm_hl_low="#f4ede8";
        thm_hl_med="#dfdad9";
        thm_hl_high="#cecacd";

    elif [[ $theme == moon ]]; then

        thm_base="#232136";
        thm_surface="#2a273f";
        thm_overlay="#393552";
        thm_muted="#6e6a86";
        thm_subtle="#908caa";
        thm_text="#e0def4";
        thm_love="#eb6f92";
        thm_gold="#f6c177";
        thm_rose="#ea9a97";
        thm_pine="#3e8fb0";
        thm_foam="#9ccfd8";
        thm_iris="#c4a7e7";
        thm_hl_low="#2a283e";
        thm_hl_med="#44415a";
        thm_hl_high="#56526e";

    fi

    # Aggregating all commands into a single array
    local tmux_commands=()

    # Status bar
    set "status" "on"
    set status-style "fg=$thm_pine,bg=$thm_base"
    set monitor-activity "on"
    set status-justify "left"
    set status-left-length "100"
    set status-right-length "100"

    # Theoretically messages (need to figure out color placement) 
    set message-style "fg=$thm_text,bg=$thm_base,align=centre"
    set message-command-style "fg=$thm_text,bg=$thm_surface,align=centre"

    # Pane styling
    set pane-border-style "fg=$thm_hl_high"
    set pane-active-border-style "fg=$thm_gold"
    set display-panes-active-colour "${thm_text}"
    set display-panes-colour "${thm_gold}"

    # Windows
    #setw window-status-separator "  "
    setw window-status-separator " "
    #setw window-status-style "fg=${thm_foam},bg=${thm_hl_med}"
    #setw window-status-activity-style "fg=${thm_base},bg=${thm_rose}"
    #setw window-status-current-style "fg=${thm_base},bg=${thm_gold}"

    # Statusline base command configuration: No need to touch anything here
    # Placement is handled below

    # NOTE: Checking for the value of @rose_pine_window_tabs_enabled
    local show_window
    show_window="$(get_tmux_option "@rose_pine_current_window" "")"
    readonly show_window

    local show_user
    show_user="$(get_tmux_option "@rose_pine_user" "")"
    readonly show_user

    local show_host
    show_host="$(get_tmux_option "@rose_pine_host" "")"
    readonly show_host

    local date_time_format
    date_time_format="$(get_tmux_option "@rose_pine_date_time" "")"
    readonly date_time_format

    local show_directory
    show_directory="$(get_tmux_option "@rose_pine_directory" "")"

    local wt_enabled
    wt_enabled="$(get_tmux_option "@rose_pine_window_tabs_enabled" "off")"
    readonly wt_enabled

    local right_separator
    right_separator="$(get_tmux_option "@rose_pine_right_separator" "  ")"

    local left_separator
    left_separator="$(get_tmux_option "@rose_pine_left_separator" "  ")"

    local field_separator
    field_separator="$(get_tmux_option "@rose_pine_field_separator" " | " )"

    local spacer
    spacer=" "

    # These variables are the defaults so that the setw and set calls are easier to parse

    local window_in_window_status
    #readonly window_in_window_status="#[fg=$thm_bg,bg=$thm_foam] #I#[fg=$thm_foam,bg=$thm_bg]$left_separator#[fg=$thm_fg,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_fg,bg=$thm_bg]#W "
    readonly window_in_window_status="#{?window_activity_flag,#[fg=$thm_base]#[bg=$thm_rose],#[fg=$thm_foam]#[bg=$thm_hl_med]} #I #[fg=$thm_subtle,bg=$thm_surface] #W "
    readonly window_in_window_status_current="#[fg=$thm_base,bg=$thm_gold] #I #[fg=$thm_subtle,bg=$thm_surface] #W "

    local session
    readonly session=" #[fg=$thm_text] #[fg=$thm_text]#S "

    local user
    readonly user="#[fg=$thm_iris]#(whoami)#[fg=$thm_subtle]$right_separator#[fg=$thm_subtle]"

    local host
    readonly host=" #[fg=$thm_text]#H #[fg=$thm_subtle]$right_separator#[fg=$thm_subtle]󰒋"

    local date_time
    readonly date_time="#[fg=$thm_foam]$date_time_format#[fg=$thm_subtle]$right_separator#[fg=$thm_subtle]󰃰"

    local directory
    readonly directory=" #[fg=$thm_subtle] #[fg=$thm_rose]#{b:pane_current_path}"

    local directory_in_window_status
    readonly directory_in_window_status="#[fg=$thm_bg] #I #[fg=$thm_fg] #{b:pane_current_path} "

    local directory_in_window_status_current
    readonly directory_in_window_status_current=" #I #[fg=$thm_iris,bg=$thm_bg] #{b:pane_current_path}"

    # Right columns
    local right_column1
    local right_column2

    if [[ "$show_host" == "on" ]]; then
        right_column1=$right_column1$host
    fi

    if [[ "$date_time_format" != "" ]]; then
        if [[ "$right_column1" != "" ]]; then
            right_column1=$right_column1$field_separator
        fi
        right_column1=$right_column1$date_time
    fi

    if [[ "$show_user" == "on" ]]; then
        right_column1=$right_column1$user
    fi
    
    if [[ "$show_directory" == "on" ]]; then
        right_column1=$right_column1$spacer$directory
    fi

    local status_left
    if [[ "$show_session" == "on" ]]; then
        status_left=$status_left$session
    fi

    set status-left "$status_left"

    set status-right "$right_column1$right_column2"

    # set -g status-interval 1

    # Window status
    local window_status_format
    local window_status_current_format

    if [[ "$wt_enabled" == "on" ]]; then
        # show last command's name
        window_status_format=$window_in_window_status
        window_status_current_format=$window_in_window_status_current
    else
        # show working directory
        window_status_format=$directory_in_window_status
        window_status_current_format=$directory_in_window_status_current
    fi

    setw window-status-format "$window_status_format"
    setw window-status-current-format "$window_status_current_format"

    # tmux integrated modes 

    setw clock-mode-colour "${thm_love}"
    setw mode-style "fg=${thm_gold}"

    # Call everything to action

    tmux "${tmux_commands[@]}"

}

main "$@"
