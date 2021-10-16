#!/bin/bash

# load environment variables.
source .env.sh

# key for azure remote state
ACCOUNT_KEY=$(az storage account keys list --resource-group $TF_RESOURCE_GROUP_NAME --account-name $TF_STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
export ARM_ACCESS_KEY=$ACCOUNT_KEY

# terraform work -out run.plan
terraform init \
    -backend-config="resource_group_name=$TF_RESOURCE_GROUP_NAME" \
    -backend-config="storage_account_name=$TF_STORAGE_ACCOUNT_NAME" \
    -backend-config="container_name=$TF_CONTAINER_NAME" \
    -backend-config="key=terraform.tfstate"

# terraform apply
terraform plan -out run.plan
terraform apply run.plan