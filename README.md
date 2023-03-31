This is a git repo, implementing a declarative Jenkins Pipeline, to automate the building, packaging, containerizing and deployment of a sample maven web app.

After creating the web app using maven archetype, we created an entire local docker infrastructure that can be found in the scripts section under the jenkins folder.

That Infrastructure consists of Docker containers with Jenkins, A Nexus repository, and a minikube Kubernetes cluster.

The app, via the Jenkins pipeline, is built, packaged and containerized, with both the war file and the docker Image pushed then to our private nexus repository. 

Then the docker image is deployed to a Kubernetes cluster and the pipeline prints the ip of our web app!

  Understanding the application:
  
  * cd into the sample-maven-web-app folder and inspect the app.
  * If you want to recreate the app follow the relative README.
  * There is also a Dockerfile and a Makefile if you want to build the application outside the Jenkins pipeline.
  
  To run:
  * In the jenkins/scripts/ folder there is a docker setup script that creates the entire infrastructure in Docker.
  * The destroy script allows you to fastly tear it down aswell.
  * In the Jenkins folder is : 
      *    **1**. The Dockerfile that build the Jenkins container.
      *    **2**. The Jenkinsfile used to deploy the web app.
  * Using an agent with maven and jdk we build and package the app. Required use of custom config.xml and the Maven plugin.
  * Then we push the local artifact to the Nexus repository container created.
  * We also build the image based on its Dockerfile. That docker image is also pushed to the docker registry of the Nexus repository.
  * Finally, after providing the necessary credentials, we connect to the minikube cluster and deploy the app. The yaml files and scripts needed for the deployment are under sample-maven-web-app/kube 
  * Check the Jenkins command line output to see the IP of the web app!
