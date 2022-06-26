FROM python:3.9-alpine3.13

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

ARG DEV=false

RUN apk update \
    && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk add --no-cache mariadb-dev


RUN python -m venv /venv && \
	/venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV == "true" ]; \
        then \
        /venv/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    rm -rf /tmp && \
	adduser \
		--disabled-password \
		--no-create-home \
		django-user

ENV PATH="/venv/bin:$PATH"

COPY ./app /app
WORKDIR /app
EXPOSE 8000

USER django-user
