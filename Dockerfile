FROM openjdk:23-ea-18-jdk-oraclelinux8

EXPOSE 8080

ADD target/my-app-1.0-SNAPSHOT.jar my-app-1.0-SNAPSHOT.jar

ENTRYPOINT ["java", "-jar","my-app-1.0-SNAPSHOT.jar"]
