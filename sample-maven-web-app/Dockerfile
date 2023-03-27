FROM maven:3.8.6-jdk-11 AS build  
COPY sample-maven-web-app/src ./src
COPY sample-maven-web-app/pom.xml  .pom.xml
RUN mvn -f .pom.xml clean package

FROM tomcat:9.0.48-jdk11-openjdk-slim
COPY --from=build target/sample-web-app.war /usr/local/tomcat/webapps/sample-web-app.war
EXPOSE 8080
