# Home assistant image

This Docker image contains a home assistant install and the integrations [go-eCharger MQTT] and [JK
BMS MQTT].

## Environment variables

Currently no environment variables are defined.

## Volumes

To persist container data you can define some volumes. Directories that contain data are

- `/media/home-assistant`
    - Contains all data of home-assistant
- `/media/home-assistant/configuration`
    - Contains the configuration dir of home-assistant`

## Development

To build and run the docker container for development execute:

```bash
docker compose --file docker-compose-dev.yaml up --build
```

[go-eCharger MQTT]: https://github.com/syssi/homeassistant-goecharger-mqtt
[JK BMS MQTT]: https://github.com/mbT-Solutions/home-assistant-jkbms-mqtt
