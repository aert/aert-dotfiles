#!/bin/bash

# run web on port 777
# docker volume create portainer_data
docker run --rm -it -p 7778:8000 -p 7777:9000 --name=portainer -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.1.1-alpine
