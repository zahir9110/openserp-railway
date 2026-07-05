# Lightweight OpenSERP — Go binary only, no headless Chrome
# ~50MB vs 2GB for the official chromedp-based image

FROM golang:1.24-alpine AS builder
RUN apk add --no-cache git ca-certificates
WORKDIR /src
RUN git clone --depth 1 https://github.com/karust/openserp.git .
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /openserp .

FROM alpine:3.21
RUN apk add --no-cache ca-certificates curl
COPY --from=builder /openserp /usr/local/bin/openserp
COPY --from=builder /src/config.yaml /config.yaml

ENV PORT=7000
EXPOSE 7000

# Explicit ENTRYPOINT + CMD
ENTRYPOINT ["openserp"]
CMD ["serve", "-a", "0.0.0.0", "-p", "7000"]
