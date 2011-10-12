# X Window Logger

A collection of bash+awk scripts that log active window usage and help gather statistics from the log files.


## Installation:

Run install.sh script from program's directory:

```bash
$ ./install.sh
```

The script installs files in /usr/lib/xwinlogger/ and adds links to /usr/bin/

## Usage:

- Start XWinLogger in background:

    `$ xwinlogger &`

- Apply automatic tagging to log file and open it in OpenOffice.org calc:

    `$ xwinlogger_autotag ~/xwinlogger/2009-02-23.log > 2009-02-23.csv;oocalc 2009-02-23.csv`

- Display stats about tag usage (using 2009-02-23.csv file generated above):

    `$ xwinlogger_stats 2009-02-23.csv`

## Hacking:

- Start XWinLogger in DEBUG mode:

    `$ DEBUG=YES LOG_DIR=/tmp PERIOD=5 xwinlogger`

- Use the source, Luke! :-)

