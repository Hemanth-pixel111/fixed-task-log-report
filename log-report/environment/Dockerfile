FROM python:3.12-slim@sha256:59bd8253a6c117b35ea4f8d5cb52467b738c6d177d6ee07e596cf564f89d3d3a

RUN pip install --no-cache-dir pytest==8.4.1

WORKDIR /app

COPY access.log /app/access.log