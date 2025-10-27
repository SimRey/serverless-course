# 1. Which version of Python to use (Base image)
FROM python:3.11-slim


# default installs (Linux packages)
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    python3-dev \
    python3-setuptools \
    gcc \
    make


# 2. What code and docs
WORKDIR /app

# Copy local_dir to /app in the container
COPY . /app
COPY requirements.txt /app/requirements.txt

EXPOSE 8000


# 3. Create a virtual environment
RUN python -m venv /opt/venv && \
    /opt/venv/bin/python -m pip install --upgrade pip && \
    /opt/venv/bin/pip install -r /app/requirements.txt

RUN apt-get remove -y --purge build-essential gcc make && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Make entrypoint script executable
RUN chmod +x ./src/entrypoint.sh


# 4. Run the application
CMD ["./src/entrypoint.sh"]