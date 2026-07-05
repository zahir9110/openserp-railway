# OpenSERP — ultra-lightweight, downloads pre-built binary
FROM alpine:3.21
RUN apk add --no-cache ca-certificates curl
RUN curl -sL "https://github.com/karust/openserp/releases/download/v0.8.6/openserp-linux-amd64-0.8.6.tgz" -o /tmp/os.tgz && \
    tar xzf /tmp/os.tgz -C /usr/local/bin/ openserp && \
    rm /tmp/os.tgz && \
    chmod +x /usr/local/bin/openserp

ENV PORT=7000
EXPOSE 7000

ENTRYPOINT ["openserp"]
CMD ["serve", "-a", "0.0.0.0", "-p", "7000"]
