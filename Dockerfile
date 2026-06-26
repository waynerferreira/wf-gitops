FROM golang AS buildando

WORKDIR /app

ADD . /app
RUN go mod init meugo && \
    go mod tidy && \
    go build -o meugo

FROM alpine
WORKDIR /wf
COPY --from=buildando /app/meugo /wf/
ENTRYPOINT ["./meugo"]
