# postgres-migration-with-flyway

you can create a migration file with the following command
```bash
bash ./create_migration.sh
```
it will ask you to select a version number and a name for the migration file

make sure to add these varibale to your repo secret

for the live/production database connected to "main" branch
LIVE_DB_URL
LIVE_DB_PORT
LIVE_DB_USER
LIVE_DB_PASSWORD

for the preview/development databse connecte to "preview" branch
PREVIEW_DB_URL
REVIEW_DB_PORT
REVIEW_DB_USER
REVIEW_DB_PASSWORD

