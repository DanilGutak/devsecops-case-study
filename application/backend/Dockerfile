FROM node:20-alpine

USER node

WORKDIR /app
COPY . .

RUN npm install
RUN npm install pg
EXPOSE 3001
CMD ["node", "index.js"]
