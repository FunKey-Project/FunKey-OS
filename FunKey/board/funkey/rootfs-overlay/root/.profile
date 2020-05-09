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

# Mount /dev/mmcblk0p1 in /boot
#echo "Mount /dev/mmcblk0p1 in /boot"
#mount /dev/mmcblk0p1 /boot/ >/dev/null 2>&1

# Start ampli if necessary
#echo "Start ampli if necessary"
if [[ "$(volume_get)" -ne "0" ]]; then
	start_audio_amp 1 >/dev/null 2>&1
fi

# Force unmute sound card and reset volume
#echo "Force unmute sound card and reset volume"
volume_set $(volume_get) >/dev/null 2>&1

# Reset saved brightness
#echo "Reset saved brightness"
brightness_set $(brightness_get) >/dev/null 2>&1

# Enable USB gadget share and internet forwarding over USB
share init&

# Start launcher
#echo "Start launcher"
start_launcher >/dev/null 2>&1 &

# Init GPIO manager
#echo "Init GPIO manager"
PREVENT_GPIOMNG_FILE=/mnt/prevent_gpiomanager
PREVENT_GPIOMNG_FILE2=/boot/prevent_gpiomanager
if [ -f $PREVENT_GPIOMNG_FILE ]; then
	echo "Found file: $PREVENT_GPIOMNG_FILE, not launching gpio manager" 
elif [ -f $PREVENT_GPIOMNG_FILE2 ]; then
	echo "Found file: $PREVENT_GPIOMNG_FILE2, not launching gpio manager" 
else
	start_gpio_manager >/dev/null 2>&1 &
fi
