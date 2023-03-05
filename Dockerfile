FROM madebytimo/base

RUN install-autonomous.sh install ffmpeg Scripts && \
    apt update && apt install -y -qq python3-dev python3-venv python3-pip \
    bluez libffi-dev libssl-dev libjpeg-dev zlib1g-dev autoconf \
    build-essential libopenjp2-7 libtiff5 libturbojpeg0-dev && \ 
    rm -rf /var/lib/apt/lists/*

RUN mkdir /media/home-assistant

RUN pip3 install homeassistant

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["hass", "--config", "/media/home-assistant/configuration"]
