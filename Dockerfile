FROM python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    ffmpeg \
    curl \
    git \
    python3-dev \
    libffi-dev \
    libssl-dev \
    libgl1 \
    libglib2.0-0 \
    pkg-config \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Node.js 18 (PyTgCalls)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

WORKDIR /app

RUN pip install --upgrade pip setuptools wheel

COPY requirements.txt .
RUN pip install --no-cache-dir --prefer-binary -r requirements.txt

COPY . .

CMD ["python3", "-m", "AviaxMusic"]
