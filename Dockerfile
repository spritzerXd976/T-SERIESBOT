FROM python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# -------------------------------------------------
# System dependencies (required for wheels & media)
# -------------------------------------------------
RUN apt-get update && apt-get install -y \
    build-essential \
    ffmpeg \
    curl \
    git \
    python3-dev \
    libffi-dev \
    libssl-dev \
    pkg-config \
    ca-certificates \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# -------------------------------------------------
# Node.js 18 (MANDATORY for PyTgCalls)
# -------------------------------------------------
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && node -v \
    && npm -v

# -------------------------------------------------
# Working directory
# -------------------------------------------------
WORKDIR /app

# -------------------------------------------------
# Upgrade pip tooling (CRITICAL)
# -------------------------------------------------
RUN pip install --upgrade pip setuptools wheel

# -------------------------------------------------
# Install Python dependencies
# -------------------------------------------------
COPY requirements.txt .
RUN pip install --no-cache-dir --prefer-binary -r requirements.txt

# -------------------------------------------------
# Copy project files
# -------------------------------------------------
COPY . .

# -------------------------------------------------
# Start bot
# -------------------------------------------------
CMD ["python3", "-m", "AviaxMusic"]
