# syntax=docker/dockerfile:1

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    python3 \
    python3-pip \
    wget \
    gnupg \
    libglib2.0-0 \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libpangocairo-1.0-0 \
    libgtk-3-0 \
    fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

# create python command
RUN ln -s /usr/bin/python3 /usr/bin/python

# install playwright
RUN pip3 install --break-system-packages playwright \
    && python3 -m playwright install chromium

WORKDIR /app

RUN curl -L https://github.com/RightNow-AI/openfang/releases/download/v0.4.4/openfang-x86_64-unknown-linux-gnu.tar.gz \
  -o openfang.tar.gz \
  && tar -xzf openfang.tar.gz \
  && mv openfang /usr/local/bin/openfang

EXPOSE 4200

ENV OPENFANG_HOME=/data

ENTRYPOINT ["openfang"]
CMD ["start"]
