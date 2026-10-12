FROM --platform=$BUILDPLATFORM madebytimo/scripts AS builder

WORKDIR /root/builder

ADD https://github.com/home-assistant/core.git#master homeassistant
RUN mkdir --parents packages/homeassistant \
    && cp homeassistant/requirements{,_all}.txt packages/ \
    && cp -r homeassistant/homeassistant/package_constraints.txt packages/homeassistant/ \
    && rm -r homeassistant

ADD https://github.com/syssi/homeassistant-goecharger-mqtt.git#:custom_components \
    custom_components
ADD https://github.com/mbT-Solutions/home-assistant-jkbms-mqtt.git#:custom_components \
    custom_components

COPY files/template template

FROM madebytimo/python

RUN install-autonomous.sh install FFmpeg NetworkTools Scripts \
    && apt update -qq && apt install -y -qq autoconf bluez build-essential \
    libffi-dev libjpeg-dev liblapack-dev libopenjp2-7 libssl-dev libtiff6 \
    libturbojpeg0-dev tzdata zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /root/builder/ /opt/home-assistant/

WORKDIR /opt/home-assistant/packages

RUN --mount=type=cache,target=/builder/cache/pip \
    export PIP_CACHE_DIR=/builder/cache/pip PIP_NO_CACHE_DIR= \
    && pip3-latest install --requirement requirements_all.txt \
    && pip3-latest install homeassistant \
    && hass --script check_config --config /opt/home-assistant/template

COPY files/entrypoint.sh files/healthcheck.sh files/run.sh /usr/local/bin/

WORKDIR /media/home-assistant
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "run.sh" ]
