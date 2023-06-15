FROM madebytimo/python

RUN install-autonomous.sh install ffmpeg Scripts && \
    apt update && apt install -y -qq autoconf bluez build-essential libffi-dev \
    libjpeg-dev libopenjp2-7 libssl-dev libtiff6 libturbojpeg0-dev zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /media/home-assistant

RUN pip3 install homeassistant

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["hass", "--config", "/media/home-assistant/configuration"]
