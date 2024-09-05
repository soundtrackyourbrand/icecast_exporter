FROM golang:1.22.6-alpine AS build

WORKDIR /go/src/icecast_exporter

RUN apk add --no-cache git

COPY . /go/src/icecast_exporter

RUN go get .

# Final stage
FROM alpine:3.20

COPY --from=build /go/bin/icecast_exporter /icecast_exporter

EXPOSE 9090
USER nobody
ENTRYPOINT ["/icecast_exporter"]
