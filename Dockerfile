FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN pip install hermes-agent

RUN useradd --create-home --shell /bin/bash hermes
USER hermes
WORKDIR /home/hermes
RUN mkdir -p .hermes
ENV PORT=3000
CMD ["hermes", "gateway", "start"]


