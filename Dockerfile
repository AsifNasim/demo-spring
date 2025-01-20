# Step 1: Build Stage
FROM ubuntu:latest AS build
RUN apt-get update && apt-get install openjdk-17-jdk -y
COPY . .
RUN ./gradlew bootJar --no-daemon

# Step 2: Run Stage
FROM openjdk:17-jdk-slim
EXPOSE 8080
COPY --from=build /build/libs/demo-1.jar app.jar

# Run the application
CMD ["java", "-jar", "app.jar"]
