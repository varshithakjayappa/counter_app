# Build stage using Maven
FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /app
COPY . .
RUN mvn clean install -DskipTests

# Runtime stage using OpenJDK
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/springboot-1.0.0.jar /app/
EXPOSE 8082
CMD ["java", "-jar", "springboot-1.0.0.jar"]