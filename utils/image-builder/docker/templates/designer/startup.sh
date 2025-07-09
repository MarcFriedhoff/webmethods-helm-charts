#!/bin/bash

export DISPLAY=:1

# Start Xfce session via VNC
vncserver ${DISPLAY} -geometry 1280x800 -depth 24

# Kill default VNC password prompt
vncpasswd -f <<<"password" > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Launch websockify for noVNC
websockify --web=/usr/share/novnc/ 6080 localhost:5901 &

# Keep container running
tail -f /dev/null
