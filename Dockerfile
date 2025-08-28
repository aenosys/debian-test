# Use the debian:sid-slim base image
FROM debian:sid-slim

# Update package lists and install curl
RUN apt-get update && apt-get install -y curl

