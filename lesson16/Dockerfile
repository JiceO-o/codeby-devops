FROM node:14 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

FROM node:14

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules

COPY --from=builder /app .

EXPOSE 5001

CMD ["npm", "start"]
