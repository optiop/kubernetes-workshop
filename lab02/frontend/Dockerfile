FROM node:21-alpine3.18

LABEL MAINTAINER="Mehrshad Lotfi <mehrshad@optiop.org>"

WORKDIR /usr/src

COPY ["package.json", "."]

RUN npm install

COPY [".", "/usr/src"]

RUN npm run build

EXPOSE 3000

CMD ["npm", "run", "start"]