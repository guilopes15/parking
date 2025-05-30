FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV POETRY_VIRTUALENVS_CREATE=false
ENV PATH="/root/.local/bin:$PATH"

WORKDIR /parking_service

COPY . .

RUN apt update && apt install -y curl build-essential libpq-dev

RUN pip install --upgrade pip
RUN pip install "poetry==1.8.5"
RUN poetry install --without dev,docs --no-interaction --no-ansi

EXPOSE 8000

CMD poetry run python manage.py migrate && poetry run python manage.py runserver 0.0.0.0:8000