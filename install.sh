#!/bin/sh

INSTALL_DIR=${INSTALL_DIR:-"/usr/lib"}
BIN_DIR=${BIN_DIR:-"/usr/bin"}

if [ ! -w $INSTALL_DIR ];then
    echo "INSTALL_DIR $INSTALL_DIR is not writable. You should probably run this script as root."  1>&2
    exit 1;
fi

if [ ! -w $BIN_DIR ];then
    echo "BIN_DIR $BIN_DIR is not writable. You should probably run this script as root." 1>&2
    exit 2;
fi

INSTALL_DIR="$INSTALL_DIR/xwinlogger"

# Create program directory and move files there:
echo "Creating INSTALL_DIR $INSTALL_DIR."
if [ ! -d $INSTALL_DIR ];then
    mkdir "$INSTALL_DIR"
fi

echo "Copying files."
cp -R * "$INSTALL_DIR/"


# Create links in BIN_DIR:
if [ -n "$BIN_DIR" ];then
    echo "Creating links in BIN_DIR $BIN_DIR."
    ln -s "$INSTALL_DIR/xwinlogger" "$BIN_DIR/xwinlogger"
    ln -s "$INSTALL_DIR/xwinlogger_autotag" "$BIN_DIR/xwinlogger_autotag"
    ln -s "$INSTALL_DIR/xwinlogger_stats" "$BIN_DIR/xwinlogger_stats"
fi

echo "Done. See README.txt for details."
