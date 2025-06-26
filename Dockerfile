# Use official Maven image to build the app
FROM maven:3.8.6-openjdk-17 AS build

# Set working directory
WORKDIR /app

# Copy the entire project
COPY . .

# Build the app
RUN mvn clean package -DskipTests

# Use JDK 17 runtime image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /app/target/*.jar webscrapping.jar

# Expose port (optional)
EXPOSE 8080

# Run the jar
CMD ["java", "-jar", "app.jar"]
