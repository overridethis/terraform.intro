#!/bin/bash

# load environment variables.
source .env.sh

# dsterraform work -out run.plan
terraform init
terraform plan -out run.plan
terraform apply run.plan