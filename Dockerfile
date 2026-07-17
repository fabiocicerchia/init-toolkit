# init-toolkit — micro image bundling wait-for-it, dockerize and healthcheck
# helpers for initContainers, entrypoint wrappers and compose depends_on gaps.
ARG DOCKERIZE_VERSION=0.9.3

FROM alpine:3.24 AS fetch
ARG DOCKERIZE_VERSION
ARG TARGETARCH=amd64
# ponytail: apk versions pinned for reproducibility; bump when alpine base bumps (Alpine GCs old versions)
RUN apk add --no-cache curl=8.21.0-r0 ca-certificates=20260611-r0 tar=1.35-r5
RUN curl -fsSL "https://github.com/jwilder/dockerize/releases/download/v${DOCKERIZE_VERSION}/dockerize-linux-${TARGETARCH}-v${DOCKERIZE_VERSION}.tar.gz" \
      | tar -xz -C / dockerize \
 && chmod 0755 /dockerize
RUN curl -fsSLo /wait-for-it \
      "https://raw.githubusercontent.com/vishnubob/wait-for-it/81b1373f17855a4dc21156cfe1694c31d7d1792e/wait-for-it.sh" \
 && chmod 0755 /wait-for-it

FROM alpine:3.24
ARG DOCKERIZE_VERSION
LABEL org.opencontainers.image.title="init-toolkit" \
      org.opencontainers.image.description="wait-for-it + dockerize + healthcheck helpers for init containers" \
      org.opencontainers.image.version="${DOCKERIZE_VERSION}" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.source="https://github.com/fabiocicerchia/init-toolkit"
RUN apk add --no-cache bash=5.3.9-r1 curl=8.21.0-r0 netcat-openbsd=1.234.1-r0 ca-certificates=20260611-r0 \
 && adduser -D -u 10001 init
COPY --from=fetch /dockerize /usr/local/bin/dockerize
COPY --from=fetch /wait-for-it /usr/local/bin/wait-for-it
COPY bin/ /usr/local/bin/
USER 10001
ENTRYPOINT ["/usr/local/bin/wait-for"]
CMD ["--help"]
