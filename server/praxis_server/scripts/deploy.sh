#!/bin/bash

# Determine the environment, must be prod
export ENV="${1}"
if [ "$ENV" != "prod" ] && [ "$ENV" != "qa" ]; then
    echo "Invalid argument. It must be either 'prod' or 'qa'."
    exit 1
fi

# Genterate random hash
HASH=$(( RANDOM % 9000 + 1000 ))$(( RANDOM % 9000 + 1000 ))$(( RANDOM % 9000 + 1000 ))$(( RANDOM % 9000 + 1000 ))
# Obtain project id from terraform
PROJECT_ID=$(terraform -chdir=terraform output -raw project_id)
echo $PROJECT_ID


if [ "$ENV" == "prod" ]; then
    docker build -t joelwalshwest/prod-praxis-server:$HASH . --target slim --platform=linux/amd64 --no-cache
    docker push joelwalshwest/prod-praxis-server:$HASH
    gcloud run deploy prod-praxis-server --image joelwalshwest/prod-praxis-server:$HASH --platform managed  --allow-unauthenticated --project $PROJECT_ID --set-env-vars="ENVIRONMENT=prod"
elif [ "$ENV" == "qa" ]; then
    docker build -t joelwalshwest/qa-praxis-server:$HASH . --target slim --platform=linux/amd64 --no-cache
    docker push joelwalshwest/qa-praxis-server:$HASH
    gcloud run deploy qa-praxis-server --image joelwalshwest/qa-praxis-server:$HASH --platform managed  --allow-unauthenticated --project $PROJECT_ID --set-env-vars="ENVIRONMENT=qa"
fi
