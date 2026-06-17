#!/bin/bash
# python_management.sh — defines the `pve` command.
#
# This lives in ~/.bashrc.d/, so .bashrc sources it on every shell startup.
# It must be sourced (not executed), because activating a virtual environment
# changes the current shell. Running it as a normal script would activate the
# venv in a subshell that disappears immediately — which is why `pve` is a
# function rather than a standalone script.
#
# pve: activate the project's Python virtual environment, creating it first
#      if it does not exist yet.
#
#   pve            # use ".venv" (the default)
#   pve -n .test   # use ".test" instead
#   pve -s         # give the new venv access to system site-packages

pve() {
    # `local OPTIND` keeps getopts' parsing position from leaking into the
    # shell. Without it, a second `pve` call would resume parsing at the wrong
    # spot because OPTIND is a global variable.
    local OPTIND
    local name=".venv"
    # Extra arguments passed to `python -m venv`. Collected as an array so we
    # can pass zero or more flags cleanly without word-splitting surprises.
    local create_args=()

    while getopts "n:s" opt; do
        case "${opt}" in
            n)
                name="$OPTARG"
                ;;
            s)
                create_args+=("--system-site-packages")
                ;;
            *)
                echo "usage: pve [-n venv_name] [-s]"
                return 1
                ;;
        esac
    done

    if [ -f "$name/bin/activate" ]; then
        echo "Activating existing virtual environment '$name'"
    else
        echo "Creating virtual environment '$name'"
        python -m venv "${create_args[@]}" "$name"
        if [ $? -ne 0 ]; then
            echo "Failed to create virtual environment '$name'"
            return 1
        fi
    fi

    source "$name/bin/activate"
}
