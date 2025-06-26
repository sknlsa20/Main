FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .         # Copy pom.xml first
RUN mvn -B dependency:go-offline
COPY . .               # Then copy the rest of the files
RUN mvn -X clean package -DskipTests

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
