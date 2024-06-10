export ENVIRONMENT=staging

# Load DOPPLER_TOKEN env var
. ./env/.env.$ENVIRONMENT

if [ "$1" == "--watch" ]; then
  doppler run -- npx tsx watch src/index.ts
else
  doppler run -- npx tsx src/index.ts
fi