
This repo contains default traefik configuration for local dev environment.

## Usage

Before first setup, make sure you have the required dependencies:

    sudo apt install make libnss3-tools

Also note that port `:80` need to be unoccupied.

To initialize the environment:

    make init

This will:

- generate locally-trusted development certificates needed to run traefik over https
- create an `.env` file (if none exists) 
- set up a docker network

To actually run the environment:

    make run

This will start a preconfigured traefik docker container. The container will occupy your port `:80`. It will also automatically start with the system but you can manage it with: `make stop` and `make restart`.

Traefik dashboard will be available here:

- http: http://traefik.mmr.localhost
- https: https://traefik.mmr.localhost

## Sample app

You can verify the environment is working with an included sample app `whoami`. Just run (in the same directory as this file): 

    docker compose up -d

The sample app should be available here:

- http: http://whoami.mmr.localhost
- https: https://whoami.mmr.localhost


## Local domains
Everything with `*.localhost` will be resolved to `127.0.0.1` so there's no need to edit `/etc/hosts` file.

The environment uses domain names matching: `*.mmr.localho[readme.md](readme.md)st`.

## Docker

A docker network `traefik-proxy-mmr-local` will be created if it does not exist.

# Using the environment with your project

Detailed instructions on how to use this environment with your project are available
[here](project_usage.md).

# Troubleshooting

- Traefik requires ports `:80` and `:443` and the container will refuse to start if something is blocking any of these.
    - to see what's listening on port 80, you can use this command: `ss -peanut | grep ":80" | grep LISTEN`
