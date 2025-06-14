FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV POETRY_VIRTUALENVS_CREATE=false
ENV PATH="/root/.local/bin:$PATH"

WORKDIR /parking_service

RUN apt update && apt install -y \
    curl build-essential libpq-dev \
    gconf-service libasound2 libatk1.0-0 libcairo2 libcups2 \
    libfontconfig1 libgdk-pixbuf2.0-0 libgtk-3-0 libnspr4 \
    libpango-1.0-0 libxss1 fonts-liberation libappindicator1 \
    libnss3 lsb-release xdg-utils

COPY . .

RUN pip install --upgrade pip
RUN pip install "poetry==1.8.5"
RUN poetry install --without dev --no-interaction --no-ansi
RUN poetry run playwright install

EXPOSE 8000


# apt clean && rm -rf /var/lib/apt/lists/* -> reduz o tamanho final da imagem

# apt install -y wget gnupg ca-certificates
