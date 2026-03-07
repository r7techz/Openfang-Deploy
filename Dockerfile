# syntax=docker/dockerfile:1

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y curl ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN curl -L https://github.com/RightNow-AI/openfang/releases/download/v0.3.26/openfang-x86_64-unknown-linux-gnu.tar.gz \
  -o openfang.tar.gz \
  && tar -xzf openfang.tar.gz \
  && mv openfang /usr/local/bin/openfang

EXPOSE 4200

ENV OPENFANG_HOME=/data

ENTRYPOINT ["openfang"]
CMD ["start"]
