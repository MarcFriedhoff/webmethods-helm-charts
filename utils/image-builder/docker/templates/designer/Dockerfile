FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    USER=root \
    DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6080

# Install packages
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies \
    novnc websockify \
    tigervnc-standalone-server tigervnc-common \
    xterm wget net-tools curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create startup script
RUN mkdir -p /opt/scripts
COPY templates/designer/startup.sh /opt/scripts/startup.sh
RUN chmod +x /opt/scripts/startup.sh

COPY --from=INSTALL /opt/softwareag /opt/softwareag

EXPOSE ${VNC_PORT} ${NO_VNC_PORT}

CMD ["/opt/scripts/startup.sh"]
