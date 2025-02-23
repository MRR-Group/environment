TLD := mmr.localhost
TRAEFIK_NETWORK_NAME := traefik-proxy-mmr-local

export COMPOSE_DOCKER_CLI_BUILD = 1
export DOCKER_BUILDKIT = 1

init:
	@cd traefik && \
	[ ! -f ".env" ] && cp .env.example .env; \
	docker network inspect ${TRAEFIK_NETWORK_NAME} --format {{.Id}} 2>/dev/null || \
	docker network create ${TRAEFIK_NETWORK_NAME}

run:
	cd traefik && docker compose up --detach

stop:
	cd traefik && docker compose stop

restart: stop run

.PHONY: init run stop restart
