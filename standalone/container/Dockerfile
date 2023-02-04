FROM registry.access.redhat.com/ubi9/s2i-core

WORKDIR /opt/app-root/bin

RUN curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    cd rclone-*-linux-amd64 && \
    cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone && \
    cd .. && \
    rm rclone-current-linux-amd64.zip && \
    rm -rf rclone-*-linux-amd64

# Launcher
COPY utils utils/
COPY run-rclone.sh ./

WORKDIR /opt/app-root/src

CMD /opt/app-root/bin/run-rclone.sh