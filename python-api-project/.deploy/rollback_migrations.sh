#!/bin/bash
#
# Simple script to revert database migrations.
#
# This script uses some env vars:
#
# env.VERSION: Image tag that will be used to run the migrations
# env.MIGRATION_VERSION: Image tag that will be used to run the migrations
# env.DATABASE_URL: The url of the database server
# env.DATABASE_NAME: The name of the database
# env.DATABASE_PORT: The port to connect to the database
# env.DATABASE_USER : The user, of course
# env.DATABASE_PASSWORD: The password, of course
#
# Usage:
# export the env vars before
# sh ./.deploy/rollback_migrations.sh

if [[ "$VERSION" && "$MIGRATION_VERSION" && "$DATABASE_URL" && "$DATABASE_NAME" && "$DATABASE_PORT" && "$DATABASE_USER" && "$DATABASE_PASSWORD" ]]; then
  docker run --rm --network=host \
      --env DATABASE_URL=$DATABASE_URL \
      --env DATABASE_NAME=$DATABASE_NAME \
      --env DATABASE_PORT=$DATABASE_PORT \
      --env DATABASE_USER=$DATABASE_USER \
      --env DATABASE_PASSWORD=$DATABASE_PASSWORD \
      "eduardomatoss/python-api-project:${VERSION}" "alembic" "downgrade" "${MIGRATION_VERSION}"
else
  echo "Missing values! You must define these env vars: VERSION, MIGRATION_VERSION, DATABASE_URL, DATABASE_NAME, DATABASE_PORT, DATABASE_USER and DATABASE_PASSWORD!"
  exit 1
fi
