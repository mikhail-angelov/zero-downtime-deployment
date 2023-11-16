# Zero downtime deployment with docker compose and nginx reverse proxy

The purpose of this repo is to demonstrate blue-green deployment for simple application which is run under docker compose.

## Make commands

`make build` - will build docker image with small ech application and tag it with version

## if you manage to run docker compose `docker compose up`

`make deploy-blue version=<your ver>` - will gracefully shut down blue container, remove it, create new blue container with target version, run it and restore load balancer to route traffic to new container 

`make deploy-green version=<your ver>` - same for green

`make blue-down` - will gracefully shut down traffic for blue container
`make blue-up` - will restore traffic for blue container