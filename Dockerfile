FROM maven:3.8.4-openjdk-17 AS build
COPY pom.xml /build/
COPY src /build/src
WORKDIR /build/
RUN mvn clean package -DSkipTests

FROM openjdk:17-jdk-alpine
EXPOSE 32777
ARG JAR_FILE=/build/target/*.jar
COPY --from=build /build/target/biocad_task-0.0.1-SNAPSHOT.jar biocad_task.jar
ENTRYPOINT ["java", "-jar", "biocad_task.jar"]
