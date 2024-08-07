# Start with a base image containing Java runtime
FROM maven:3.9.5 AS build
WORKDIR /app
COPY pom.xml /app
RUN mvn dependency:resolve
COPY . /app
RUN mvn clean
RUN mvn package -DskipTests -X

FROM openjdk
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8091
ENTRYPOINT ["java","-jar","/app.jar"]
