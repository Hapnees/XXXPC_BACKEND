FROM node

WORKDIR /app/backend

COPY package.json .
RUN yarn install
COPY . .

EXPOSE 4000

CMD ["yarn", "start:dev"]
