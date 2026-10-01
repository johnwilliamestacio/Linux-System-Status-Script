# Linux System Status Checker

A simple Bash script for checking the basic status of a Linux system.

This project was made as a beginner-friendly solution to the Linux System Status assignment.

## What it checks

The script reports:

- CPU core count and load average
- Memory and swap usage
- Disk usage
- System uptime
- Top processes using CPU
- Top processes using memory
- Network interfaces and IP addresses
- Listening ports
- Logged-in users
- Current user and whether the script is running as root
- Current date and time

These checks directly follow the main requirements of the assignment. fileciteturn0file0L3-L12

## Requirements

The script is designed to work on common Linux distributions.

It uses simple Linux commands such as:

- `bash`
- `free`
- `df`
- `ps`
- `ip`
- `ss`
- `who`
- `uptime`

If some optional commands are missing, the script prints a message instead of stopping completely.

This follows the assignment requirement for platform support and graceful degradation. fileciteturn0file0L13-L20

## Installation

Clone the repository:

```bash
git clone https://github.com/YOUR-USERNAME/linux-system-status-checker.git
```

Go into the folder:

```bash
cd linux-system-status-checker
```

Make the script executable:

```bash
chmod +x linux-system-status.sh
```

## Usage

### Normal output

```bash
./linux-system-status.sh
```

### JSON output

```bash
./linux-system-status.sh --json
```

The normal output is intended for people reading the terminal.

The `--json` option gives a small structured output that can be used by another script or tool.

## Example

The actual values will depend on the Linux machine where the script is executed.

```text
======================================
       LINUX SYSTEM STATUS
======================================

SYSTEM
------
Hostname : my-linux
User     : student
Date     : 2026-10-01 23:30:00+08:00
Root     : No

CPU
---
CPU cores : 4
Load avg  : 0.20, 0.15, 0.10

MEMORY
------
               total        used        free
Mem:           7.7Gi       2.1Gi       1.5Gi
Swap:          2.0Gi          0B       2.0Gi

UPTIME
------
up 2 hours, 10 minutes

DISK
----
Filesystem      Size  Used Avail Use%
/dev/sda1        50G   20G   28G  42%

TOP PROCESSES BY CPU
--------------------
  PID USER      %CPU %MEM COMMAND
 1201 student    5.2  2.1 firefox
  900 student    2.1  1.0 code

NETWORK
-------
lo               UNKNOWN        127.0.0.1/8
eth0             UP             192.168.1.10/24

LISTENING PORTS
---------------
Netid State  Local Address:Port
tcp   LISTEN 127.0.0.1:22

LOGGED-IN USERS
---------------
student   pts/0

======================================
              END
======================================
```

## Design choices

### Read-only

The script only reads system information. It does not:

- install software
- change configuration
- stop services
- kill processes
- create files on the Linux system

This satisfies the assignment's idempotent requirement. fileciteturn0file0L23-L23

### Non-interactive

The script does not ask the user for input or a password, so it can also be run without a TTY.

### Permissions

The script checks whether the current user is root:

```bash
id -u
```

It does not automatically use `sudo`.

### Date format

The script attempts to use RFC 3339-compatible date output as required by the assignment. fileciteturn0file0L27-L27

## Project structure

```text
linux-system-status-checker/
├── README.md
└── linux-system-status.sh
```

## Author

Your Name
