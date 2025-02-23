# Instructions how to add new app to existing Traefik environment

## Requirements

- app has to be dockerized

## Setup

1. Declare a traefik network in your docker-compose file

```yaml
# docker-compose.yml
networks:
    traefik-proxy-mmr-local:
        external: true
```

2. Add this network **only** to the container which serves your application (nginx, apache, or other built-in servers, etc.)

```yaml
# docker-compose.yml
services:
    your-service:
        networks:
            - traefik-proxy-mmr-local
```

3. Add labels to the docker compose service

```yaml
# docker-compose.yml
services:
    your-service:
        labels:
            - "traefik.enable=true"
            - "traefik.mmr.environment=true"
            - "traefik.http.routers.NAME-http-router.rule=Host(`DOMAIN.mmr.localhost`)"
            - "traefik.http.routers.NAME-http-router.entrypoints=web"
```

Where **NAME** should be replaced with your app name slug (no spaces) and **DOMAIN** should be replaced with an app name that you'll use in url, e.g.: if DOMAING is set to `my-app` then your app will be accessible with: `my-app.mmr.localhost`.

You can also use `.env` file to provide domain name, e.g.:

```yaml
# docker-compose.yaml
- "traefik.http.routers.NAME.rule=Host(`${YOUR_APP_HOST_NAME}`)"
```

```dotenv
# .env file

YOUR_APP_HOST_NAME=my-app.mmr.localhost
```

### Notes:
- If you don't need to use Traefik to redirect traffic to your app, either remove `traefik.enabled` label or set it to false:

```yaml
- "traefik.enable=false"
```

you can also remove `traefik-proxy-mmr-local` network.

- Traefik will automatically detect **exposed, (not published)** ports and use the first one. If your app exposes more than one port, you need to specify which Traefik should use to redirect traffic correctly. To do this, you can use a label:

```yaml
- "traefik.http.services.NAME.loadbalancer.server.port=9000"
```

Where **NAME** is your app name slug and **9000** is the expected port.

# Examples

### HTTP only

```yaml
services:
    your-service:
        labels:
            - "traefik.enable=true"
            - "traefik.mmr.environment=true"
            - "traefik.http.routers.NAME-http-router.rule=Host(`DOMAIN.mmr.localhost`)"
            - "traefik.http.routers.NAME-http-router.entrypoints=web"            
```