ARG BANK_VAULTS_VERSION=0.6.3
ARG VAULT_VERSION=1.2.3

FROM banzaicloud/bank-vaults:${BANK_VAULTS_VERSION} as builder

# No Action

FROM vault:${VAULT_VERSION}

LABEL org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.description="Alpine Linux image with Hashicorp's vault and Banzaicloud's bank-vaults." \
      org.label-schema.docker.cmd="docker run -it --rm cjmach/vault-configurator" \
      org.label-schema.name="cjmach/vault-configurator" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.url="https://github.com/cjmach/vault-configurator" \
      org.label-schema.vcs-ref="${SOURCE_COMMIT}" \
      org.label-schema.vcs-url="https://github.com/cjmach/vault-configurator" \
      org.label-schema.vendor="cjmach" \
      org.label-schema.version="${SOURCE_BRANCH}"

COPY --from=builder /usr/local/bin/template /usr/local/bin/template
COPY --from=builder /usr/local/bin/bank-vaults /usr/local/bin/bank-vaults

RUN apk add --no-cache jq