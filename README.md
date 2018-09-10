# Demos for the OSS Virtual Conference

## Prerequisites
This assumes that the following binaries are installed:

* `docker`
* `kubectl`

This also assumes that you have a working Kubernetes cluster. You can create a
cluster using (Azure Kubernetes Service)[https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough].

## Clone the repo
```sh
git clone https://github.com/brendandburns/oss-conference-demos
```

## Export your repository name
```sh
export REPO=<your-docker-repository>
```

## Running the build and scale demo
```sh
# Move into the demo directory
cd oss-conference-demos/build-deploy

# Run the demo (it's self typing)
./demo.sh
```

You can find a screen capture of this demo session on ASCII Cinema

## Running the deployment demo
```sh
# Move into the demo directory
cd oss-conference-demos/deployment

# Run the demo (it's self-typing)
./demo.sh
```

You can find a screen capture of this demo session on ASCII Cinema
