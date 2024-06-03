export ENVIRONMENT=staging

if [ "$1" == "--watch" ]; then
  npx dotenv -e env/.env -- npx tsx watch src/index.ts
else
  npx dotenv -e env/.env -- npx tsx src/index.ts
fi