FROM ubuntu:focal

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get -y install python3 python-is-python3 xvfb x11vnc xdotool wget tar supervisor net-tools gnupg2 curl software-properties-common x11-utils && \
    apt-get -y install xfce4 xfce4-goodies firefox fonts-liberation fonts-dejavu-core fonts-freefont-ttf onboard && \
    echo '$$Hello1$$' > /root/x11vnc_password.txt && \
    wget -qO - https://dl.winehq.org/wine-builds/winehq.key | apt-key add - && \
    echo 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' | tee /etc/apt/sources.list.d/winehq.list && \
    apt-get update && \
    apt-get -y install --install-recommends winehq-stable winetricks && \
    apt-get -y full-upgrade && apt-get clean && rm -rf /var/lib/apt/lists/*
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD supervisord-wine.conf /etc/supervisor/conf.d/supervisord-wine.conf
ADD supervisord-onboard.conf /etc/supervisor/conf.d/supervisord-onboard.conf
ADD start.sh /root/start.sh
ADD healthcheck.sh /root/healthcheck.sh
ADD install-roblox-studio.sh /root/install-roblox-studio.sh
ADD install-vinegar.sh /root/install-vinegar.sh
ADD setup-desktop.sh /root/setup-desktop.sh
RUN chmod +x /root/start.sh /root/healthcheck.sh /root/install-roblox-studio.sh /root/install-vinegar.sh /root/setup-desktop.sh

ENV WINEPREFIX /root/prefix64
ENV WINEARCH win64
ENV DISPLAY :0

WORKDIR /root/
RUN wget -O - https://github.com/novnc/noVNC/archive/v1.3.0.tar.gz | tar -xzv -C /root/ && mv /root/noVNC-1.3.0 /root/novnc && ln -s /root/novnc/vnc_lite.html /root/novnc/index.html && \
    wget -O - https://github.com/novnc/websockify/archive/v0.11.0.tar.gz | tar -xzv -C /root/ && mv /root/websockify-0.11.0 /root/novnc/utils/websockify

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD ["/root/healthcheck.sh"]

CMD ["/root/start.sh"]
