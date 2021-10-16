#!/bin/bash

# load environment variables.
sh .env.sh

# terraform work -out run.plan
terraform destroy -auto-approve