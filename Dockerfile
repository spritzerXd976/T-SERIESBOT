FROM python:3.10-slim

# System deps
RUN apt-get update && apt-get install -y \
    ffmpeg \
    git \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install uv
RUN pip install --no-cache-dir uv

# Copy dependency files FIRST (important for cache)
COPY pyproject.toml uv.lock ./

# Install dependencies (THIS IS THE FIX)
RUN uv sync --frozen

# Copy project source
COPY . .

# Start bot
CMD ["uv", "run", "python", "-m", "PURVIMUSIC"]
