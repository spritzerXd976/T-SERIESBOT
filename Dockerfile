FROM python:3.10-slim

# System dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    ffmpeg \
    curl \
    git \
    python3-dev \
    libffi-dev \
    libssl-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Node.js 18 (PyTgCalls requirement)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

WORKDIR /app

COPY requirements.txt .

# 🔥 IMPORTANT FIX
RUN pip install --upgrade pip setuptools wheel

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python3", "-m", "AviaxMusic"]
