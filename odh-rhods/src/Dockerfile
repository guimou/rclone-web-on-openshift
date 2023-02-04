FROM registry.access.redhat.com/ubi9

RUN yum install unzip -y && \
    yum clean all

RUN mkdir -p /tmp/rclone
WORKDIR /tmp/rclone

RUN curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    cd rclone-*-linux-amd64 && \
    cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone

CMD [ "rclone" ]