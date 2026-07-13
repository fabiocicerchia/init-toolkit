#!/usr/bin/env sh
# Smoke test: helpers exist; wait-for succeeds against a live TCP port and
# fails fast against a dead one.
set -eu
IMAGE="${1:?usage: test.sh <image:tag>}"
docker run --rm --entrypoint sh "$IMAGE" -c 'command -v dockerize wait-for-it wait-for healthcheck-http healthcheck-tcp >/dev/null && echo tools-present'
docker run --rm --entrypoint sh "$IMAGE" -c 'nc -l -p 8080 & sleep 1; wait-for tcp://127.0.0.1:8080 -t 5 -- echo reachable'
if docker run --rm "$IMAGE" tcp://127.0.0.1:9999 -t 2 2>/dev/null; then
  echo "FAIL: expected timeout" >&2; exit 1
fi
echo PASS
