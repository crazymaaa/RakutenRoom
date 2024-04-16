FROM ghcr.io/puppeteer/puppeteer:19.7.2

USER root

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

RUN apt-get update && \
    apt-get install -y xvfb

USER node

ENV DISPLAY=:99

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm ci
COPY . .

# Start xvfb and run the application
CMD xvfb-run --auto-servernum --server-args="-screen 0 1280x1024x24" npx nodemon app.js