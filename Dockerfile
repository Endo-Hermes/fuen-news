FROM python:3.12-slim

WORKDIR /app

1. Instalar dependencias del sistema (necesarias para compilar)
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

2. Instalar Hermes Agent
RUN pip install hermes-agent

3. Crear usuario y directorio de trabajo
RUN useradd --create-home --shell /bin/bash hermes
USER hermes
WORKDIR /home/hermes
RUN mkdir -p .hermes

4. Comando de inicio
CMD ["hermes", "gateway", "start"]
