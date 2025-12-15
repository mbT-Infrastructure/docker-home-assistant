FROM madebytimo/scripts AS builder

WORKDIR /root/builder

COPY files/template template
RUN mkdir custom_components \
    && download.sh --output goecharger-mqtt.tar.gz \
        https://github.com/syssi/homeassistant-goecharger-mqtt/archive/refs/heads/main.tar.gz \
    && compress.sh --decompress goecharger-mqtt.tar.gz \
    && mv homeassistant-goecharger-mqtt-main/custom_components/goecharger_mqtt custom_components \
    && rm -r goecharger-mqtt.tar.gz homeassistant-goecharger-mqtt-main

FROM madebytimo/python

RUN install-autonomous.sh install FFmpeg NetworkTools Scripts \
    && apt update -qq && apt install -y -qq autoconf bluez build-essential \
    libffi-dev libjpeg-dev liblapack-dev libopenjp2-7 libssl-dev libtiff6 \
    libturbojpeg0-dev tzdata zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*


COPY --from=builder /root/builder /opt/home-assistant

RUN python3-latest -m venv /opt/home-assistant/venv \
    && source /opt/home-assistant/venv/bin/activate \
    && pip install homeassistant wheel \
    && hass --script check_config --config /opt/home-assistant/template

COPY files/entrypoint.sh files/healthcheck.sh files/run.sh /usr/local/bin/

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "run.sh" ]
