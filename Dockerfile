# Use current Node LTS (Alpine) as base image
FROM node:22-alpine3.21

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install

#Install ca-certificates package
RUN apk update && apk add --no-cache wget ca-certificates

#Download New CA Certificate
RUN wget -O /usr/local/share/ca-certificates/comodoca.crt "https://comodoca.my.salesforce.com/sfc/dist/version/download/?oid=00D1N000002Ljih&ids=0683l00000ENwaHAAT&d=/a/3l000000VZ4M/ie5Sho19m8SLjTZkH_VL8efOD1qyGFt9h5Ju1ddtbKQ&operationContext=DELIVERY&viewId=05HUj00000KwUGpMAN&dpt="

#Update the certificate store
RUN update-ca-certificates
COPY . .
CMD [ "node", "app.js" ]