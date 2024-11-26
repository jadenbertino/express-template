FROM --platform=linux/amd64 node:20-bookworm
WORKDIR /app

# Install Doppler CLI: https://docs.doppler.com/docs/cli#installation
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg && \
    curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | gpg --dearmor -o /usr/share/keyrings/doppler-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/doppler-archive-keyring.gpg] https://packages.doppler.com/public/cli/deb/debian any-version main" | tee /etc/apt/sources.list.d/doppler-cli.list && \
    apt-get update && \
    apt-get -y install doppler

# Install packages
COPY package.json package-lock.json ./
RUN --mount=type=secret,id=npmrc,target=/root/.npmrc npm ci

# Copy source code
COPY CHANGELOG.md ./
COPY ./docker ./docker/
RUN chmod -R +x ./docker
COPY dist/ dist/

# Start the app
ENV HISTIGNORE='export DOPPLER_TOKEN*'
CMD ["doppler", "run", "--", "node", "dist/index.js"]