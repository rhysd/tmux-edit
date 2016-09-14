#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OPENER="${CURRENT_DIR}/scripts/open_editor.sh"

default_edit_key="E"
fallback_edit_command="vim"

get_tmux_option() {
    local option="$1"
    local default_value="$2"
    local option_value=$(tmux show-option -gqv "$option")
    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

get_editor_command() {
    local edit=$(get_tmux_option "@edit-command", "$EDITOR")
    if [ -z "$edit" ]; then
        edit="$fallback_edit_command"
    fi
    echo $edit
}

set_copy_mode_edit_bindings() {
    local key=$(get_tmux_option "@edit-binding", "$default_edit_key")
    local cmdline="${OPENER} \"$(get_editor_command)\" \"\$(tmux show-buffer)\""
    tmux bind-key -t vi-copy "$key" run-shell "$cmdline"
    tmux bind-key -t emacs-copy "$key" run-shell "$cmdline"
}

main() {
    set_copy_mode_edit_bindings
}

main
