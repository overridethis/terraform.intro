#!/bin/bash

# load environment variables.
source .env.sh

# terraform work -out run.plan
terraform init
terraform plan -out run.plan
terraform apply run.plan