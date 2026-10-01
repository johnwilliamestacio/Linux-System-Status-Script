#!/bin/bash

# Simple Linux System Status Checker
# Read-only script for basic Linux system information.

show_human() {
    echo "======================================"
    echo "       LINUX SYSTEM STATUS"
    echo "======================================"

    echo
    echo "SYSTEM"
    echo "------"
    echo "Hostname : $(hostname)"
    echo "User     : $(whoami)"
    echo "Date     : $(date --rfc-3339=seconds 2>/dev/null || date)"

    if [ "$(id -u)" -eq 0 ]; then
        echo "Root     : Yes"
    else
        echo "Root     : No"
    fi

    echo
    echo "CPU"
    echo "---"
    echo "CPU cores : $(nproc 2>/dev/null || echo "Unknown")"
    echo "Load avg  : $(uptime | awk -F'load average:' '{print $2}' 2>/dev/null || echo "Unknown")"

    echo
    echo "MEMORY"
    echo "------"
    free -h 2>/dev/null || echo "Memory information unavailable."

    echo
    echo "UPTIME"
    echo "------"
    uptime -p 2>/dev/null || uptime

    echo
    echo "DISK"
    echo "----"
    df -h 2>/dev/null || echo "Disk information unavailable."

    echo
    echo "TOP PROCESSES BY CPU"
    echo "--------------------"
    ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu 2>/dev/null | head -n 6 || \
        echo "Process information unavailable."

    echo
    echo "TOP PROCESSES BY MEMORY"
    echo "----------------------"
    ps -eo pid,user,%cpu,%mem,comm --sort=-%mem 2>/dev/null | head -n 6 || \
        echo "Process information unavailable."

    echo
    echo "NETWORK"
    echo "-------"
    if command -v ip >/dev/null 2>&1; then
        ip -brief address
    else
        echo "The 'ip' command is not available."
    fi

    echo
    echo "LISTENING PORTS"
    echo "---------------"
    if command -v ss >/dev/null 2>&1; then
        ss -tuln
    else
        echo "The 'ss' command is not available."
    fi

    echo
    echo "LOGGED-IN USERS"
    echo "---------------"
    if command -v who >/dev/null 2>&1; then
        who
    else
        echo "The 'who' command is not available."
    fi

    echo
    echo "======================================"
    echo "              END"
    echo "======================================"
}

show_json() {
    # Simple JSON-style output using shell tools.
    # Values are mainly intended for quick machine-readable use.
    hostname_value=$(hostname 2>/dev/null)
    user_value=$(whoami 2>/dev/null)
    cores_value=$(nproc 2>/dev/null || echo "unknown")
    uptime_value=$(awk '{print $1}' /proc/uptime 2>/dev/null || echo "unknown")

    if [ "$(id -u)" -eq 0 ]; then
        root_value=true
    else
        root_value=false
    fi

    echo "{"
    echo "  \"hostname\": \"$hostname_value\","
    echo "  \"user\": \"$user_value\","
    echo "  \"root\": $root_value,"
    echo "  \"cpu_cores\": \"$cores_value\","
    echo "  \"uptime_seconds\": \"$uptime_value\","
    echo "  \"timestamp\": \"$(date --rfc-3339=seconds 2>/dev/null || date)\""
    echo "}"
}

if [ "$1" = "--json" ]; then
    show_json
else
    show_human
fi
