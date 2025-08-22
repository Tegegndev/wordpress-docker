# Use the official n8n base image
FROM docker.n8n.io/n8nio/n8n:latest

# Set environment variables
ENV GENERIC_TIMEZONE="UTC"
ENV TZ="UTC"
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
ENV N8N_RUNNERS_ENABLED=true

# Expose the n8n default port
EXPOSE 5678

# (Optional) Install extra dependencies
# RUN apk add --no-cache curl nano

# Set working directory
WORKDIR /home/node

# Volume for n8n data
VOLUME ["/home/node/.n8n"]

# Start n8n
CMD ["n8n"]
