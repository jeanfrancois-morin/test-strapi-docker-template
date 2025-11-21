FROM node:20

WORKDIR /opt/app

# Enable corepack for Yarn (Node 20 has it built-in)
RUN corepack enable

# Copy dependency manifests first (better layer caching)
COPY package.json yarn.lock* ./

# Install dependencies inside container (gets correct linux builds)
RUN if [ -f yarn.lock ]; then yarn install; \
    else npm install; fi

# Copy rest of application source
COPY . .

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 1337

# Use development mode for hot-reload
ENV NODE_ENV=development

ENTRYPOINT ["docker-entrypoint.sh"]
