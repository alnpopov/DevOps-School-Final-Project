#
# This Dockerfile build boxfuse app and make docker image
# with tomcat web-server and WAR artifact inside 
#
FROM maven:3-jdk-8 AS build
LABEL maintainer="alnp"

RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR boxfuse-sample-java-war-hello
RUN mvn clean package

FROM tomcat:8.5-jdk8

WORKDIR /usr/local/tomcat/webapps
COPY --from=build /boxfuse-sample-java-war-hello/target/*.war .
