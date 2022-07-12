FROM node:13-alpine
EXPOSE 3000

ENV MONGO_DB_USERNAME=root \
    MONGO_DB_PWD=root

RUN mkdir -p /home/app

COPY ./app /home/app

# set default dir so that next commands executes in /home/app dir
# will execute npm install in /home/app because of WORKDIR
RUN apk update \
    apk add curl

WORKDIR /home/app
RUN npm install

# no need for /home/app/server.js because of WORKDIR
CMD ["node", "/home/app/server.js"]
# CMD ["npm", "run", "start"]
