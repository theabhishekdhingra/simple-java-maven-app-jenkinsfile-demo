FROM openjdk:17

EXPOSE 8080

ADD target/myApp-1.0-SNAPSHOT.jar myApp-1.0-SNAPSHOT.jar

ENTRYPOINT ["java", "-jar","myApp-1.0-SNAPSHOT.jar"]
