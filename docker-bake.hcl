variable "BASE_IMAGE_DATE" {
    default = "unknown"
}
variable "VERSION" {
    default = "v0.0.1"
}

target "default" {
    tags = [
        "madebytimo/home-assistant:latest",
        "madebytimo/home-assistant:${VERSION}",
        "madebytimo/home-assistant:${VERSION}-base-${BASE_IMAGE_DATE}"
    ]
    platforms = [
        "amd64",
        "arm64",
        "arm",
    ]
}