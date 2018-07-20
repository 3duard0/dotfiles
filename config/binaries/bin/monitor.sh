#!/bin/bash

function print_usage {
    echo "Usage: $0 MONITOR1 MONITOR2 [OPTION]"
    echo
    echo "Options:"
    echo "--auto (-a) try to configure both monitors automatically"
    echo "--left (-l) only left monitor on"
    echo "--right (-r) only right monitor on"
    echo "--both (-b) turn on both monitors"
}

function both_monitors {
    echo "Turning on both monitors"
    `xrandr --output $MONITOR1 --auto --left-of $MONITOR2 --output $MONITOR2 --auto`
}

function left_monitor {
    echo "Turning on only $MONITOR1"
    `xrandr --output $MONITOR1 --auto --output $MONITOR2 --off`
}

function right_monitor {
    echo "Turning on only $MONITOR2"
    `xrandr --output $MONITOR1 --off --output $MONITOR2 --auto`
}

function auto_both_monitors {
    echo "Auto detecting monitors"
    CON_MONITOR1=$(echo "$xrandr_out" | grep "$MONITOR1 connected")
    CON_MONITOR2=$(echo "$xrandr_out" | grep "$MONITOR2 connected")

    if [ "$CON_MONITOR1" ] && [ "$CON_MONITOR2" ] ; then
        both_monitors
    elif [ "$CON_MONITOR1" ] ; then
        left_monitor
    else
        right_monitor
    fi
}

if [ $# -lt 2 ] ; then
    print_usage
    exit 1
fi

MONITOR1="$1"
MONITOR2="$2"
shift
shift
echo "Monitor 1 set to: $MONITOR1"
echo "Monitor 2 set to: $MONITOR2"

xrandr_out=$(xrandr)

case "$1" in
    --auto|-a)
        auto_both_monitors
        exit 0
        ;;
    --left|-l)
        left_monitor
        exit 0
        ;;
    --right|-r)
        right_monitor
        exit 0
        ;;
    --both|-b)
        both_monitors
        exit 0
        ;;
    *) print_usage
esac

