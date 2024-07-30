FROM adoptopenjdk/openjdk11  AS build
# maven:3.8.5-openjdk-17
# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml file and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code and build the application
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Create a lightweight image for running the application
FROM adoptopenjdk/openjdk11:alpine-jre

# Set the working directory inside the container
ENV APP_HOME /usr/src/app
WORKDIR $APP_HOME

# Copy the built JAR file from the build stage
COPY --from=build /app/target/*.jar ./app.jar

# Expose the application's port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]















# FROM maven:3.8.4-openjdk-11
# # adoptopenjdk/openjdk11
  
# EXPOSE 8080
 
# ENV APP_HOME /usr/src/app

# COPY target/*.jar $APP_HOME/app.jar

# WORKDIR $APP_HOME

# CMD ["java", "-jar", "app.jar"]
