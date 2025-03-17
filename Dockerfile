FROM node:23 AS step1
WORKDIR /app
COPY package.json .
RUN --mount=type=cache,target=/root/.npm npm install
COPY . .
# /app/dist/hello/browser
RUN npm run build

FROM nginx:1.27.4
COPY --from=step1 /app/dist/hello/browser /usr/share/nginx/html
