FROM node:20

# Set working directory
WORKDIR /opt/app

# Copy all application files including node_modules
COPY . ./

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Expose the Strapi port
EXPOSE 1337

# Set environment to production
ENV NODE_ENV=production

# Start Strapi using custom entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]
