FROM golang AS buildando

WORKDIR /app

COPY meugo.go /app/

RUN go mod init meugo && \
    go mod tidy && \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o meugo

FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /wf

COPY --from=buildando /app/meugo /wf/

EXPOSE 8080

ENTRYPOINT ["/wf/meugo"]