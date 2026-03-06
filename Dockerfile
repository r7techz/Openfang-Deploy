# syntax=docker/dockerfile:1

FROM rust:1-slim-bookworm AS builder

WORKDIR /build

RUN apt-get update && apt-get install -y git pkg-config libssl-dev && rm -rf /var/lib/apt/lists/*

# clone openfang repo
RUN git clone https://github.com/RightNow-AI/openfang.git .

# checkout version
RUN git checkout v0.3.24

RUN cargo build --release --bin openfang


FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/target/release/openfang /usr/local/bin/
COPY --from=builder /build/agents /opt/openfang/agents

EXPOSE 4200

VOLUME /data

ENV OPENFANG_HOME=/data

ENTRYPOINT ["openfang"]
CMD ["start"]
