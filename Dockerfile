############# builder
FROM golang:1.15.8 AS builder

WORKDIR /go/src/github.com/gardener/gardener-extension-os-suse-chost
COPY . .
RUN make install-requirements && make generate && make install

############# gardener-extension-os-suse-chost
FROM alpine:3.13.2 AS gardener-extension-os-suse-chost

COPY --from=builder /go/bin/gardener-extension-os-suse-chost /gardener-extension-os-suse-chost
ENTRYPOINT ["/gardener-extension-os-suse-chost"]
