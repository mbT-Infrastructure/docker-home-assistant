# Home assistant image

This Docker image contains a home assistant install.

Additionally it includes ffmpeg and some scripts.

## Environment variables

Currently no enviironment variables are defined.

## Volumes

To persist container data you can define some volumes. Directories that contain data are

- `/media/home-assistant`
    - Contains all data of home-assistant
- `/media/home-assistant/configuration`
    - Contains the configuration dir of home-assistant`


## Development

To build the image locally run:
```bash
./docker-build.sh
```