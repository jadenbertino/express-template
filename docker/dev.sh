export ENVIRONMENT=staging

# Load DOPPLER_TOKEN env var
. ./env/.env.$ENVIRONMENT
export HISTIGNORE='export DOPPLER_TOKEN*'
export DOPPLER_TOKEN=$DOPPLER_TOKEN

if [ "$1" == "--watch" ]; then
  doppler run -- npx tsx watch src/index.ts
else
  doppler run -- npx tsx src/index.ts
fi