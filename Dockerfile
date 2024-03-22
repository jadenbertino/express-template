FROM --platform=linux/amd64 node:20-bookworm
WORKDIR /app

# Install packages
COPY package.json package-lock.json ./
RUN --mount=type=secret,id=npmrc,target=/root/.npmrc npm ci

# Copy source code
COPY ./docker ./docker/
RUN chmod -R +x ./docker
COPY dist/ dist/

# Start the app
CMD npm run start