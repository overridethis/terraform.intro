# Demo
## Hello Terraform! 

Showcase some of the Terraform CLI basics we will run through the **Docker Build** tutorial at [hashicorp.com](https://learn.hashicorp.com/tutorials/terraform/docker-build?in=terraform/docker-get-started). The goal of the demo is to automate the deployment of a local an nginx webserver in a local **Docker** environment.  While this demo is overly complex for what it accomplishes it does allow us to showcase the **Terraform CLI** cycle efficiently.

## Resources
1. Nginx Official Image - https://hub.docker.com/_/nginx/
2. Terraform CLI - https://learn.hashicorp.com/tutorials/terraform/install-cli
3. Docker CLI 
```
docker run -d -p -p 8080:80 --name webserver nginx
```
