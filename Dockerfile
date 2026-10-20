FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*
RUN pip install "hermes-agent[messaging]"
  

RUN useradd --create-home --shell /bin/bash hermes
USER hermes
ENV HOME=/home/hermes

WORKDIR /home/hermes
RUN mkdir -p .hermes


ENV HERMES_DASHBOARD=1
ENV HERMES_DASHBOARD_PORT=5005
ENV HERMES_DASHBOARD_BASIC_AUTH_USERNAME=osint_fuenla
ENV TELEGRAM_ALLOWED_USERS=538951954
RUN python -c "import telegram; print('telegram import OK')"

CMD ["sh","-c","printf \"model:\n  default: glm5.3-flash\n  provider: custom\n  base_url: https://api.nan.builders/v1\n  api_key: ${NAN_API_KEY}\n\" > /home/hermes/.hermes/config.yaml; hermes dashboard --host 0.0.0.0 --port ${HERMES_DASHBOARD_PORT:-5005} --no-open & exec hermes gateway run"]



