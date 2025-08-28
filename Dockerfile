# Use the debian:sid-slim base image
FROM debian:sid-slim

# Update package lists and install curl
RUN apt-get update && apt-get install -y curl

# Expose a dummy port for testing purposes.
# This informs Docker that the container listens on this network port at runtime.
EXPOSE 80

# Set the default executable for the container.
# For dummy testing, this entrypoint starts an interactive bash shell.
ENTRYPOINT ["/bin/bash"]
