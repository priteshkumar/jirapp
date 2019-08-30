FROM python:3

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

RUN apt-get update && apt-get install -y \
		gcc \
		gettext \
		default-libmysqlclient-dev \
		libpq-dev \
		sqlite3 \
		iputils-ping vim curl wget \
	--no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV DJANGO_VERSION 2.1.4
RUN pip install mysqlclient django=="$DJANGO_VERSION" djangorestframework markdown django-filter coreapi django-crispy-forms

EXPOSE 8080
cmd python manage.py migrate && python manage.py runserver 0.0.0.0:8080
