# OpenSERP — ultra-lightweight, downloads pre-built binary
FROM alpine:3.21
RUN apk add --no-cache ca-certificates curl
RUN curl -sL "https://github.com/karust/openserp/releases/download/v0.8.6/openserp_Linux_x86_64.tar.gz" -o /tmp/os.tar.gz && \
    tar xzf /tmp/os.tar.gz -C /usr/local/bin/ openserp && \
    rm /tmp/os.tar.gz && \
    chmod +x /usr/local/bin/openserp

ENV PORT=7000
EXPOSE 7000

ENTRYPOINT ["openserp"]
CMD ["serve", "-a", "0.0.0.0", "-p", "7000"]
