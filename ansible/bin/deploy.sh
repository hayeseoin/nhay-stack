#!/usr/bin/env bash

NHAY_STACK_CONF_D="/home/eoinh/nhay-stack/conf.d"
DEPLOYMENTS=$(ls "$NHAY_STACK_CONF_D")

for i in  $DEPLOYMENTS; do 
    if [[ ! -d "$NHAY_STACK_CONF_D"/"$i"/nhay-stack ]]; then
        continue
    fi
    echo "$i is ready"
    cd "$NHAY_STACK_CONF_D"/"$i"/nhay-stack
    docker compose up -d
done