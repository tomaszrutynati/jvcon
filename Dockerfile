FROM openjdk:8 AS build
WORKDIR /app/
COPY . /app/
RUN chmod +x gradlew
RUN ./gradlew clean build

FROM openjdk:8-jre-alpine
WORKDIR /app/
COPY --from=build /app/build/libs/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.edg=file:/dev/./urandom","-jar","/app/app.jar"]