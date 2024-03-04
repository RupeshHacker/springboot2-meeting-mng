# Use a base image with JDK 13 and Maven installed
FROM maven:3.6.3-jdk-13 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven POM file to the container
COPY pom.xml .

# Copy the entire source code to the container
COPY src ./src

# Build the application
RUN mvn package

# Use a lightweight base image with JRE 13 installed
FROM openjdk:13-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the packaged JAR file from the build stage to the container
COPY --from=build /app/target/springboot2-meetingmng-0.0.1-SNAPSHOT.jar .

# Expose the port the application runs on
EXPOSE 8080

# Define the command to run the application when the container starts
CMD ["java", "-jar", "springboot2-meetingmng-0.0.1-SNAPSHOT.jar"]
