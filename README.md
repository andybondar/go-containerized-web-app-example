# Go 'Hello World' containerized application

## Intorduction
This tutorial aims to guide the beginners through the process of creating, building and deploying a Simple Go Web Application.

## Requirements
* GitHub account
* Docker Hub account
* An IDE or at least a text editor
* Docker Engine running locally on your computer is recommended
* User account in AWS, GCP, Azure or any other Cloud Platform will be helpful. Without one you won't be able to provision a Kubernetes Cluster in the Cloud.

* Optionally, you may want to install Go Development Kit on your computer. However, I would recommend using [containerized Dev Environment](#containerized-development-environment) rather than installing everything locally, but it is up to you.

## Writing the Application
Create folder `app` to put the 1st file with Application Code into it. You can use the [example here](app/server.go), modify it or write your own code using your favorite IDE. If you don't have any experience with Go language, the [Go website](https://go.dev/) is a good point to start.

## Building the Application
Once you're happy with what your code looks like, you can build and containrize the Application. Go to the root folder of your repository (where the `Dockerfile` is located) and run this:
```
docker build -t go-web-helloworld:0.0.1 .
```

## Running the Application on your Desktop
### Prerequisites
TBD

### Manual run
TBD

#### Containerized Development environment
TBD

#### Creating Development environment on your computer
TBD

### Compiling binary exacutable file
TBD

## Provisioning a Kubernetes Cluster
TBD

## Running the Application in a Kubernetes cluster
TBD

## Using CI/CD
### GitHub Actions