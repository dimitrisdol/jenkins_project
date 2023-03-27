In order to create, dockerize and deploy this basic maven web app.

	1. Pull the repo
	2. change the Makefile values to your Dockerhub account info 
	3. run: make
	4. docker push <your-dockerhub-name>/sample-web-app:0.0.1
	5. edit the deployment.yaml and change the image tag to your repo
	6. cd to the kube/ folder and run the deploy.sh script

DONE

If you want to build the app:
	
	1. Create the maven app: mvn archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-webapp -DarchetypeVersion=1.4
	2. Copy the Makefile and change the necessary values
	3. run: make
        4. docker push <your-dockerhub-name>/sample-web-app:0.0.1
        5. edit the deployment.yaml and change the image tag to your repo
	6. cd to the kube/ folder and run the deploy.sh script

DONE

The app is then found at: localhost:8081/sample-web-app
