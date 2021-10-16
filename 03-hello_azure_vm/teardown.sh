#!/bin/bash

# load environment variables.
source .env.sh

# terraform work -out run.plan
terraform destroy -auto-approve