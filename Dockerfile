FROM python:3.10

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# ---------------- SYSTEM DEPENDENCIES ----------------
RUN apt-get update && apt-get install -y \
    ffmpeg \
    curl \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# ---------------- NODE 18 ----------------
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

WORKDIR /app

# ---------------- PYTHON TOOLS ----------------
RUN pip install --upgrade pip setuptools wheel

# ---------------- INSTALL REQUIREMENTS ----------------
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ---------------- COPY PROJECT ----------------
COPY . .

CMD ["python3", "-m", "PURVIMUSIC"]
