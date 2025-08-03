# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
export TERM=xterm
export LS_OPTIONS='--color=auto'
#eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# Alias functions for compatibility
volume_get() {
    volume get "$@"
}

volume_set() {
    volume set "$@"
}

brightness_get() {
    brightness get "$@"
}

brightness_set() {
    brightness set "$@"
}

notif_set() {
    notif set "$@"
}

start_audio_amp() {
    audio_amp "$@"
}

cancel_sched_powerdown() {
    powerdown handle
}

# Relocate HOME into the r/w partition
export HOME=/mnt/FunKey
mkdir -p "${HOME}"
export GMENU2X_HOME="$HOME/.gmenu2x"
mkdir -p "${GMENU2X_HOME}"
export RETROFE_HOME="$HOME/.retrofe"
mkdir -p "${RETROFE_HOME}"
mkdir -p "${RETROFE_HOME}/layouts"

# Resize the console to the terminal dimensions
resize() {
    if [[ -t 0 && $# -eq 0 ]]; then
        local IFS='[;' escape geometry x y
        echo -ne '\e7\e[r\e[999;999H\e[6n\e8'
        read -sd R escape geometry
        x=${geometry##*;} y=${geometry%%;*}
        if [[ ${COLUMNS} -eq ${x} && ${LINES} -eq ${y} ]]; then
            echo "${TERM} ${x}x${y}"
        else
            echo "${COLUMNS}x${LINES} -> ${x}x${y}"
            stty cols ${x} rows ${y}
        fi
    else
        print 'Usage: resize'
    fi
}

# Restore saved volume
echo "Restore saved volume"
volume set $(volume get) >/dev/null 2>&1

# Restore saved brightness
echo "Restore saved brightness"
brightness set $(brightness get) >/dev/null 2>&1

# Start Assembly tests (blocking process)
assembly_tests >/dev/null 2>&1

# Restart saved application/game if any
instant_play load

# Start frontend
echo "Start frontend"
frontend init >/dev/null 2>&1 &
