# Use the official n8n image
FROM docker.n8n.io/n8nio/n8n:latest

# Optional: set your timezone
ENV GENERIC_TIMEZONE="UTC"
ENV TZ="UTC"

# Enable stricter security and runners
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
ENV N8N_RUNNERS_ENABLED=true

# Expose the default n8n port
EXPOSE 5678

# Persist workflows & creds
VOLUME ["/home/node/.n8n"]

# Start n8n (already in image)
CMD ["n8n"]
