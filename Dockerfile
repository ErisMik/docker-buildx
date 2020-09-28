### Buildx fetch image ###
FROM alpine AS fetcher

RUN apk add --no-cache curl

ARG BUILDX_VERSION=0.4.2
RUN curl -L \
  --output /docker-buildx \
  "https://github.com/docker/buildx/releases/download/v${BUILDX_VERSION}/buildx-v${BUILDX_VERSION}.linux-amd64"

RUN chmod a+x /docker-buildx

### Buildx runtime image ###
FROM docker:stable AS runtime

COPY --from=fetcher /docker-buildx /usr/lib/docker/cli-plugins/docker-buildx
