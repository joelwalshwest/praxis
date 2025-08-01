# syntax=docker/dockerfile:1
# check=skip=SecretsUsedInArgOrEnv

# Slim image with required dependencies only

FROM python:3.11-slim AS slim

WORKDIR /code
COPY ./requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY ./src ./src

CMD ["uvicorn", "src.main:app", "--timeout-keep-alive", "0", "--host", "0.0.0.0", "--port", "8080"]

# Dev image with a full development environment

FROM joelwalshwest/my-development-environment AS dev
ARG OPENAI_API_KEY
ENV OPENAI_API_KEY=${OPENAI_API_KEY}

RUN apt-get update && apt-get install -y python3 python3-pip

WORKDIR /code
COPY ./requirements.txt ./
RUN python -m venv /my-venv
RUN /my-venv/bin/pip install --no-cache-dir -r requirements.txt
ENV PATH="/my-venv/bin:$PATH"

COPY . .

# Copy local nvim configurations
COPY .nvim/local.lua /root/.config/nvim/lua/joelwalshwest/
RUN echo "require('joelwalshwest.local')" >> /root/.config/nvim/lua/joelwalshwest/init.lua
CMD ["zsh"]
