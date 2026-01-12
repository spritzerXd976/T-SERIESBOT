FROM python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# ---------------- SYSTEM DEPENDENCIES ----------------
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

# ---------------- NODEJS 18 (PyTgCalls) ----------------
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

WORKDIR /app

# ---------------- PYTHON TOOLS ----------------
RUN pip install --upgrade pip setuptools wheel

# ---------------- INSTALL REQUIREMENTS ----------------
COPY requirements.txt .
RUN pip install --no-cache-dir --prefer-binary -r requirements.txt

# ---------------- COPY PROJECT ----------------
COPY . .

CMD ["python3", "-m", "PURVIMUSIC"]
