FROM node

MAINTAINER  Attila Szeremi <attila+webdev@szeremi.com>

RUN mkdir /src
WORKDIR /src
RUN cd /src

# Copy just the package.json file file as a cache step.
COPY package.json /src
# Disable progress so npm would install faster.
# Disable colors, because Dockerhub can't display them.
# Install NPM packages excluding the dev dependencies.
RUN npm set progress=false && npm set color=false && npm install

COPY elm-package.json /src
# Now run the elm package installer, saying "yes" to everything.
RUN node_modules/.bin/elm-package install -y

COPY . .
ENV NODE_ENV=production
RUN npm run build
EXPOSE  8080
CMD ["npm", "run", "start"]
