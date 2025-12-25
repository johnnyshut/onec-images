#!/bin/bash

# Проверка наличия необходимых переменных среды
if [[ -z "$DOCKER_REGISTRY_URL" || -z "$DOCKER_LOGIN" || -z "$DOCKER_PASSWORD" ]]; then
    echo "Ошибка: Необходимо установить переменные среды DOCKER_REGISTRY_URL, DOCKER_LOGIN и DOCKER_PASSWORD."
    exit 1
fi

set +x

login_url="$DOCKER_REGISTRY_URL"
if [[ "$DOCKER_REGISTRY_URL" == docker.io/* ]]; then
    login_url="docker.io"
elif [[ "$DOCKER_REGISTRY_URL" != *.* ]] && [[ "$DOCKER_REGISTRY_URL" != */* ]]; then
    login_url="docker.io"
fi

echo "$DOCKER_PASSWORD" | docker login "$login_url" -u "$DOCKER_LOGIN" --password-stdin

if [[ $? -eq 0 ]]; then
    echo "Успешная авторизация в $login_url"
else
    echo "Ошибка авторизации в $login_url"
    exit 1
fi