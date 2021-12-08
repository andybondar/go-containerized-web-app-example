# Go 'Hello World' containerized application

## Introduction
This tutorial aims to guide the beginners through the process of creating, building and deploying a Simple Go Web Application.

## Requirements
* GitHub account
* Docker Hub account
* An IDE or at least a text editor
* Docker Engine running locally on your computer is recommended
* User account in AWS, GCP, Azure or any other Cloud Platform will be helpful. Without one, you won't be able to provision a Kubernetes Cluster in the Cloud.

* Optionally, you may want to install Go Development Kit on your computer. However, I would recommend using a [containerized Dev Environment](#containerized-development-environment) rather than installing everything locally, but it is up to you.

## Writing the Application
Create folder `app` to put the 1st file with Application Code into it. You can use the [example here](app/server.go), modify it, or write your own code using your favorite IDE. If you don't have any experience with Go language, the [Go website](https://go.dev/) is a good point to start.

## Building the Application
Once you're happy with what your code looks like, you can build and containerize the Application. Go to the root folder of your repository (where the `Dockerfile` is located) and run this:
```
docker build -t go-web-helloworld:0.0.1 .
```

## Running the Application on your Desktop
### Prerequisites
* Application Code, written in `Go`
* `Docker Engine` installed on your computer - if you want to go with `Containerized Development Environment`
* `Go` compiler and other necessary tools - if you want to go with `Local Development Environment`

### Manual run
#### Containerized Development Environment
Run `golang` container using official image from [DockerHub](https://hub.docker.com/_/golang?tab=tags&page=1&name=1.16.10-alpine3.14):
```
docker run -it -v /home/user/go-containerized-web-app-example/app:/app --name goapp --rm golang:1.16.10-alpine3.14
```
assuming that `/home/user/go-containerized-web-app-example/app` is the directory where your App's code is stored.

Inside the container, run your App:
```
# cd /app/
# go run main.go
```

Now, open a new Terminal Window or Tab and `exec` inside the running container:
```
docker exec -it goapp sh
```

Inside the container, run the following:
```
# netstat -ntpl
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 :::8080

# apk add curl

# curl http://127.0.0.1:8080
<h1>Hello World</h1>
```
As you can see, the Application listens on port 8080 and responds to HTTP requests.

#### Creating Development environment on your computer
Please consult the documentation:
https://go.dev/doc/install

### Compiling binary executable file
To compile the executable binary, change the directory to where your App's code is stored and run `go build` (assuming that you're using `Containerized Development environment`):
```
# cd /app/
# go build -o /app/go-web-helloworld .
```

Now, you should be able to find the executable file in the root (`/`) directory:
```
# ls -lh /go-web-helloworld 
-rwxr-xr-x    1 root     root        5.9M Dec  5 20:57 /app/go-web-helloworld
```

## Provisioning a Kubernetes Cluster
TBD

## Running the Application in a Kubernetes cluster
### Assumptions
* Kubernetes cluster you want to deploy your Application to, is up and running
* The Container Image containing your App, is published to the [Docker Hub](https://hub.docker.com/) Container Registry

### k8s objects
There are 3 k8s objects that we're going to create here:
* Namespace - `ns.yaml`
* Deployment - `deployment.yaml`
* Service - `svc.yaml`

Please find the `yaml` files in the `k8s` folder.

### Deployment
It is assumed that kubectl CLI is installed on your computer. Connect to the Kubernetes Cluster, change directory to `k8s` and run the following commands:
```
kubectl apply -f ns.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml 
```

## Using CI/CD
### GitHub Actions
#### Basics
Here are some examples of the `software development workflows`:
* Processing request from GitHub user wanting to join the project as a contributor (verification of his or her identity, granting access, etc.)
* Processing new pull request (running some tests, assigning it to somebody who can review, reporting status to its creator, merging it to master branch when it's ready, etc)
* Processing new issue from user (sorting and prioritizing the issue, assigning to someone who can handle it, reporting its status, etc)
* etc.

Basic concept of the `GitHub Actions` - it listens to the `Events` that happen IN or TO your repository, and it takes pre-defined `Actions` on those events.
In this tutorial, we will use `GitHub Actions` to automate a CI/CD workflow.

For more basic information on the `GitrHub Actions` please watch [this video](https://www.youtube.com/watch?v=R8_veQiYBjI&t=1207s). For more detailed information, please read [the documentation](https://docs.github.com/en/actions).

In the GitHub Web UI, go to your repository and then to the `Actions` Tab, to see the Workflows statuses.

#### Test every new push
Please review the simple workflow defined in the [.github/workflows/container_image.yml](.github/workflows/container_image.yml). It is supposed to be run on each push to any branch (assuming that the `main` branch is protected from direct pushes) and also on merge request to the `main` branch. The `container_image.yml` workflow verifies the App's ability to be built, to run and respond to HTTP requests.

#### Releasing Docker Image to Docker Hub.
It is also supposed to be automated by using `GitHub Actions`. Before it's done, you can build the container image and push it to the Docker Hub Registry using code from the `master` banch and `docker` CLI tool:

* Clone the repo to your computer, assuming that you do have the `Docker Engine` installed
* Login to [DockerHub WebUI](https://hub.docker.com/) and create an Access Token: Dropdown under your account's avatar -> Account Settings -> Security -> New Access Token
* Copy the Access Token and save it in a safe place for furhter usage
* In the command line terminal, do the following:
```
cd go-containerized-web-app-example/
docker build -t go-web-helloworld:0.0.1 .
docker tag go-web-helloworld:0.0.1 {your_dockerhub_account_name}/go-web-helloworld:0.0.1
docker push {your_dockerhub_account_name}/go-web-helloworld:0.0.1
```