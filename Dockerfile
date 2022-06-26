FROM python:3.9-alpine3.13

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt

RUN python -m venv /venv && \
	/venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install -r /tmp/requirements.txt && \
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
