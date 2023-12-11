#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 START|STOP|STATUS"
    exit 1
fi

PID_FILE="/tmp/monitor_pid"

start_monitor() {
    if [ -e "$PID_FILE" ]; then
        echo "Error: Monitor is already running. PID: $(cat $PID_FILE)"
        exit 1
    fi

    echo "Starting monitor..."
    ./monitor_script.sh &   # Здесь предполагается, что у вас есть отдельный скрипт monitor_script.sh для мониторинга

    # Сохраняем PID процесса в файл
    echo $! > "$PID_FILE"
    echo "Monitor started. PID: $(cat $PID_FILE)"
}

stop_monitor() {
    if [ ! -e "$PID_FILE" ]; then
        echo "Error: Monitor is not running."
        exit 1
    fi

    echo "Stopping monitor..."
    kill -9 $(cat "$PID_FILE")
    rm "$PID_FILE"
    echo "Monitor stopped."
}

status_monitor() {
    if [ -e "$PID_FILE" ]; then
        echo "Monitor is running. PID: $(cat $PID_FILE)"
    else
        echo "Monitor is not running."
    fi
}

case $1 in
    "START")
        start_monitor
        ;;
    "STOP")
        stop_monitor
        ;;
    "STATUS")
        status_monitor
        ;;
    *)
        echo "Unknown command: $1. Use START|STOP|STATUS."
        exit 1
        ;;
esac

