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
For both Ente Auth and Photos/Album are running on port 80 internally, so when running them, bind any port to port 80.
Examples,

```docker run --name ente-web-auth -p 3007:80 -e ENDPOINT=https://auth.domain.tld ma04/ente-web-auth```
```
  web:
    image: ma04/ente-web-auth
    container_name: ente-web-auth
    ports:
      - '3007:80'
    environment:
      - ENDPOINT=https://auth.domain.tld
      - TZ="Asia/Dhaka"
```