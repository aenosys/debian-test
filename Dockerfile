# Use the official Ubuntu 22.04 LTS image as a stable base.
FROM ubuntu:22.04

# Set the DEBIAN_FRONTEND to noninteractive to prevent prompts during apt-get installation.
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists, install all required packages in a single layer, and clean up.
# --no-install-recommends reduces the number of installed packages.
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Web Server
    nginx \
    \
    # Python Environment
    python3 \
    python3-pip \
    python3-venv \
    \
    # Common & Useful Utilities
    curl \
    git \
    procps \
    unzip \
    ca-certificates \
    nano \
    && \
    # Clean up the apt cache to reduce image size
    rm -rf /var/lib/apt/lists/*

# --- Nginx Configuration ---
# IMPORTANT: Replace 'nginx.conf' with the actual path to your config file.
COPY nginx.conf /etc/nginx/nginx.conf

# IMPORTANT: Replace 'your-static-site/' with the actual name of your site's folder.
COPY your-static-site/ /var/www/html/

# --- Python Application Setup ---
# Set a working directory for your application.
WORKDIR /app

# IMPORTANT: If you don't use Python or 'requirements.txt', delete or comment out the next 4 lines.
COPY requirements.txt .
# Install Python packages into a virtual environment (best practice).
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir -r requirements.txt

# Copy your application code.
COPY . .

# Expose the port Nginx will listen on.
EXPOSE 80

# The command to run when the container starts.
# This starts Nginx in the foreground, which is required for Docker containers.
CMD ["nginx", "-g", "daemon off;"]

# --- Alternative CMD if you want to run a Python web app (e.g., with Gunicorn) ---
# CMD ["gunicorn", "--bind", "0.0.0.0:80", "your_app:app"]
