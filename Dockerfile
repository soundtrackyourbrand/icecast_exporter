FROM golang:1.22.6-alpine AS golang

WORKDIR /src

RUN apk add --no-cache git

COPY . /src

RUN go get .
RUN CGO_ENABLED=0 go build -installsuffix 'static' \
    -o /bin/app /src/icecast_exporter.go

# Final stage
FROM gcr.io/distroless/base

COPY --from=golang /bin/app /application

USER nobody
ENTRYPOINT ["/application"]
