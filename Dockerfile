# Stage 1: Build the application
FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /app
COPY my-app/pom.xml .
COPY my-app/src ./src
COPY my-app/checkstyle.xml .
RUN mvn clean package

# Stage 2: Test the application
FROM build AS test
RUN mvn test

# Stage 3: Create the final image
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
ENTRYPOINT ["java", "-jar", "app.jar"]
