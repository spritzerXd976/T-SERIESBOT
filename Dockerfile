FROM python:3.10-slim

# Prevent interactive installs
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    ffmpeg \
    curl \
    git \
    python3-dev \
    libffi-dev \
    libssl-dev \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 18 (required for PyTgCalls)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

WORKDIR /app

# Upgrade pip tools (VERY IMPORTANT)
RUN pip install --upgrade pip setuptools wheel

# Copy requirements
COPY requirements.txt .

# Install Python dependencies (verbose for debugging)
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

CMD ["python3", "-m", "PURVIMUSIC"]
