FROM node:17.9.0
# Install node

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . ./

RUN npm run build

EXPOSE 5173

CMD ["npm", "run",  "dev", "--", "--host"]

