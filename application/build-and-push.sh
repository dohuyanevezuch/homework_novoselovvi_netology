#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Использование: $0 cr.yandex/<REGISTRY_ID>/application:1.0"
  exit 1
fi

IMAGE="$1"

docker build -t "$IMAGE" .
docker push "$IMAGE"

echo "Образ загружен: $IMAGE"