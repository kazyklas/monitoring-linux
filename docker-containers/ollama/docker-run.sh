#!/bin/bash

docker run -d \
        --net=host \
        -e OLLAMA_BASE_URL=http://127.0.0.1:11434 \
        -v open-webui:/app/backend/data \
        --name open-webui \
        --restart unless-stopped \
        ghcr.io/open-webui/open-webui:main