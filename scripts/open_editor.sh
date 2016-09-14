#!/usr/bin/env bash

main() {
    local cmd="$1"
    local file="$(echo $2 | tr -d '[[:space:]]')"

    # XXX:
    # Need to escape key sequence like 'C-x'
    local cmdline="${cmd} -- ${file}"
    tmux send-keys "$cmdline"
    tmux send-keys 'C-m'
}

main "$1" "$2"
