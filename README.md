## Setup

1. Download this template WITHOUT git history
```bash
wget https://github.com/jadenbertino/express-template/archive/refs/heads/main.zip
unzip main.zip
rm main.zip
```

Note: If you don't have `unzip` then do `sudo apt-get update && sudo apt-get install unzip`

2. `package.json` > set the `deploy` script to run `deploy-azure.sh` or `deploy-gcloud.sh` depending on what platform you are deploying to

3. `docker/config.sh` > set the `SERVICE_NAME` & `DOCKER_TAG`

4. Create a `env/.env` file (even if empty)

5. Build image with `npm run build`

6. Run container `ENVIRONMENT=development npm run test`

7. Send a `GET` request to `localhost:8080/` -> should see a hello world message

8. Kill the container with `Ctrl+C`

9. Happy coding!

## Updates
[For latest updates, see the notion page](https://www.notion.so/jadenbertino/Docker-CI-CD-Best-Practices-Scripts-eff92e4f8ca648ad8baa78b1319fbd0a?pvs=4)

[You can view the `express-template` Github Repository here](https://github.com/jadenbertino/express-template)
