# nhayStack (WIP)

Platform for container deployment on a Linux Virtual Private Servers (VPS)

## Goals
The goal of this project is to create a framework for deploying docker containers on a VPS. 

The idea is that any repo can be deployed on this instance if it includes a required file `nhay-stack/compose.yaml`

This allows apps and sites to be self contained in their own repo for continuos development, but allows consistent deployment using seperated logic.  This stategy allows for consistent deployment on any VPS server, without needing to carefully configure a new server when changing VPS providers. The framework should also allow for multiple apps and sites to be deployed on the same server. This means multiple low traffic sites and apps can be deployed cost effectively on cheaper VPS services. 

## Architecture

The platform is based on a Traefik docker container as a reverse proxy egress point for the apps and sites, and predictable docker networking, compose file creation and folder structure for ease of deployment.

## Usage
Structure the repos like below. The command `nhay-stack deploy` will deploy all docker compose files found in `nhay-es/compose.yaml`

```sh
nhay-stack/
├── cmburns-app
│   ├── docker-compose.yaml
│   ├── nhay-stack
│   │   └── compose.yaml
│   └── README.md
├── food-blog
│   ├── docker-compose.yaml
│   ├── nhay-stack
│   │   └── compose.yaml
│   └── README.md
└── tech-blog
    ├── docker-compose.yaml
    ├── nhay-stack
    │   └── compose.yaml
    └── README.md
```
---
## To-do List

 [✅] Install docker on a blank server
 [✅] Create docker network
 [✅] Create Traefik depoymenton that network
 [] Create a basic new app with an `nhay-stack/compose.yaml` file which will deploy automatically to Traefik 

## Progress

Deploy a vm from `terraform/main.tf`
The playbook `ansible/site.yml` installs docker and deploys a traefik container
The playbook `ansible/whoami.yml` deploys a test app to Traefik

Labels like this in `nhay-stack/compose.yml` should glue everything together
```sh
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.whoami.rule=Host(`stack.nhay.es`)"
      - "traefik.http.routers.whoami.entrypoints=web"
```