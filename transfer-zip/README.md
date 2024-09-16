# Configuration
Running both of these container is required.
`APP_URL` is the URL of the app, where the app is running. equivalent to REACT_APP_APP_URL

```
  web:
    image: ghcr.io/ma-04/transfer-zip-web
    container_name: transfer-web
    ports:
      - '3004:80'
    environment:
      - APP_URL=https://domain.tld
      - TZ="Asia/Dhaka"
  signaling:
    image: ghcr.io/ma-04/transfer-zip-signaling-server
    container_name: signaling-server
    restart: unless-stopped
```