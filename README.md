## Setup

- Download this template WITHOUT git history
```bash
wget https://github.com/jadenbertino/express-template/archive/refs/heads/main.zip
unzip main.zip
rm main.zip
```

Note: If you don't have `unzip` then do `sudo apt-get update && sudo apt-get install unzip`

- `package.json` > set the `deploy` script to run `deploy-azure.sh` or `deploy-gcloud.sh` depending on what platform you are deploying to

- `docker/config.sh` > set the `SERVICE_NAME` & `DOCKER_TAG`

- Build image with `npm run build`

- Run container `ENVIRONMENT=development npm run test`

- Send a `GET` request to `localhost:8080/` -> should see a hello world message

- Kill the container with `Ctrl+C`

- Happy coding!

## Updates

[You can view the `express-template` Github Repository here](https://github.com/jadenbertino/express-template)
