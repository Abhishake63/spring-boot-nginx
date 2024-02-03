FROM eclipse-temurin:17-alpine
RUN mkdir /opt/app
COPY target/*.war /opt/app/app.war
ENTRYPOINT ["java", "-jar", "/opt/app/app.war"]