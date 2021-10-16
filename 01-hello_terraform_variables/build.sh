#!/bin/bash

# load environment variables.
sh .env.sh

# terraform work -out run.plan
terraform init
terraform plan -out run.plan
terraform apply run.plan