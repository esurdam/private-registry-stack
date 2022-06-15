#!/bin/bash

OUTPUT_DIR="ssl"
DOMAIN_NAME="$1"

[ -z ${DOMAIN_NAME} ] && (echo "DOMAIN_NAME is unset" && exit 1)

mkdir -p "$OUTPUT_DIR" && \
    openssl req -x509 \
        -newkey rsa:4096 \
        -keyout "$OUTPUT_DIR/key.pem" \
        -out "$OUTPUT_DIR/cert.pem" \
        -sha256 \
        -days 3365 \
        -nodes \
        -subj "/CN=${DOMAIN_NAME}" \
        -addext "extendedKeyUsage = serverAuth" \
        -addext "subjectAltName = DNS:$DOMAIN_NAME"