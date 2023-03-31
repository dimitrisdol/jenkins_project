This is a git repo, implementing a declarative Jenkins Pipeline, to automate the building, packaging, containerizing and deployment of a sample maven web app.

After creating the web app using maven archetype, we created an entire local docker infrastructure that can be found in the scripts section under the jenkins folder

That Infrastructure consists of a Docker container with Jenkins, A Nexus repository, and a minikube kubernetes cluster.

The app is packaged and containerized, with both the war file and the docker Image pushed to our private nexus repository. 

Then the docker image is deployed to a Kubernetes cluster and the pipeline prints the ip of our web app!
