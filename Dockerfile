FROM python:3.10-slim

# Environment safety
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV CRYPTOGRAPHY_DONT_BUILD_RUST=1

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ffmpeg \
    curl \
    git \
    python3-dev \
    libffi-dev \
    libssl-dev \
    ca-certificates \
    gnupg \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 18 (PyTgCalls requirement)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements first (cache layer)
COPY requirements.txt .

# Upgrade pip tools (🔥 VERY IMPORTANT)
RUN pip install --upgrade pip setuptools wheel

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy bot source code
COPY . .

# Start bot
CMD ["python3", "-m", "PURVIMUSIC"]
