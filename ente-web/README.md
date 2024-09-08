# Image on Docker Hub and ghcr.io
`ma04/ente-web-auth` / `ghcr.io/ma-04/ente-web-auth` <br>
`ma04/ente-web-photos` \ `ghcr.io/ma-04/ente-web-photos`

A docker image for photos-Web-Frontend/App from [ente-io](https://ente.io/).  
Works with the Backend-Server from ente-io `ghcr.io/ente-io/server`.  
There was no docker image for the docker-frontends, but a Dockerfile in the Community:  
https://help.ente.io/self-hosting/guides/external-s3#_1-create-a-compose-yaml-file   

So there now two docker images:  
- auth-App: ma04/ente-web-auth von https://github.com/ma-04/docker_builds/tree/main/ente-io_web-auth
- photos-App: ma-04/ente-web-photos von https://github.com/ma-04/docker_builds/tree/main/ente-io_web-photos

Multiarch build not working, so only amd64. 

# Configuration
For both Ente Auth and Photos/Album are running on port 80 internally. And they require some Environment variables to be set

Ente Auth:
  - ENDPOINT : (Required) Endpoint for Ente Museum/Server, equivalent to `NEXT_PUBLIC_ENTE_ENDPOINT`
  - ALBUMS_ENDPOINT : (optional) Endpoint for Ente album, equivalent to `NEXT_PUBLIC_ENTE_ALBUMS_ENDPOINT`
Ente Photos:
  - ENDPOINT : (Required) Endpoint for Ente Museum/Server, equivalent to `NEXT_PUBLIC_ENTE_ENDPOINT`
  - ALBUMS_ENDPOINT : (Required) Endpoint for Ente album, equivalent to `NEXT_PUBLIC_ENTE_ALBUMS_ENDPOINT`

```docker run --name ente-web-auth -p 3007:80 -e ENDPOINT=https://auth.domain.tld ma04/ente-web-auth```
```docker run --name ente-web-photos -p 3008:80 -e ENDPOINT=https://auth.domain.tld -e ALBUMS_ENDPOINT=https://album.domain.tld ma04/ente-web-auth```
```
  auth:
    image: ghcr.io/ma-04/ente-web-auth
    container_name: ente-web-auth
    ports:
      - '3007:80'
    environment:
      - ENDPOINT=https://auth.domain.tld
      - TZ="Asia/Dhaka"
  photos:
    image: ghcr.io/ma-04/ente-web-photos
    container_name: ente-web-photos
    ports:
      - '3008:80'
    environment:
      - ENDPOINT=https://auth.domain.tld
      - ALBUMS_ENDPOINT=https://album.domain.tld
      - TZ="Asia/Dhaka"
```