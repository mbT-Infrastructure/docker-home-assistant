FROM madebytimo/python

RUN install-autonomous.sh install FFmpeg Scripts \
    && apt update -qq && apt install -y -qq autoconf bluez build-essential libffi-dev \
    libjpeg-dev libopenjp2-7 libssl-dev libtiff6 libturbojpeg0-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install homeassistant

RUN mkdir /media/home-assistant

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["hass", "--config", "/media/home-assistant/configuration"]
