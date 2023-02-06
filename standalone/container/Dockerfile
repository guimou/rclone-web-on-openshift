FROM registry.access.redhat.com/ubi9/s2i-core

WORKDIR /opt/app-root/bin

# Install Rclone

RUN curl -OL https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    cd rclone-*-linux-amd64 && \
    cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone && \
    cd .. && \
    rm rclone-current-linux-amd64.zip && \
    rm -rf rclone-*-linux-amd64 && \
    curl -OL https://github.com/rclone/rclone-webui-react/releases/download/v2.0.5/currentbuild.zip && \
    mkdir -p /tmp/webgui/current && \
    unzip currentbuild.zip -d /tmp/webgui/current/ && \
    echo "v2.0.5" > /tmp/webgui/tag && \
    chown -R 1001:0 /tmp/webgui && \
    rm currentbuild.zip

# Install launcher
COPY utils utils/
COPY run-rclone.sh ./

USER 1001

WORKDIR /opt/app-root/src

CMD /opt/app-root/bin/run-rclone.sh