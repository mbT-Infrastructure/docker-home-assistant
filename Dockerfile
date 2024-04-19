FROM madebytimo/scripts AS builder

WORKDIR /root/builder

COPY files/template template
RUN mkdir custom_components \
    && download.sh --output goecharger-mqtt.tar.gz \
        https://github.com/syssi/homeassistant-goecharger-mqtt/archive/refs/heads/main.tar.gz \
    && compress.sh --decompress goecharger-mqtt.tar.gz \
    && mv homeassistant-goecharger-mqtt-main/custom_components/goecharger_mqtt custom_components \
    && rm -r homeassistant-goecharger-mqtt-main

FROM madebytimo/python

RUN install-autonomous.sh install FFmpeg Scripts \
    && apt update -qq && apt install -y -qq autoconf bluez build-essential liblapack-dev \
    libatlas-base-dev libffi-dev libjpeg-dev libopenjp2-7 libssl-dev libtiff6 \
    libturbojpeg0-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install homeassistant

COPY --from=builder /root/builder /opt/home-assistant

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["hass", "--config", "/media/home-assistant/configuration"]
