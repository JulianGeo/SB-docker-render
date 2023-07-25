# Stage 1: Build the application and create jar files
FROM amazoncorretto:17 as builder

# Set the working directory in the container
WORKDIR /app

# Copy the build configuration files
COPY build.gradle .
COPY settings.gradle .
COPY gradle gradle
COPY gradlew .
COPY gradlew.bat .

# Download and cache the Gradle distribution
RUN chmod +x gradlew
RUN ./gradlew --no-daemon

# Copy only the necessary files for building
COPY src src

# Build the application
RUN ./gradlew build

# Stage 2: Copy only the built jar files and create the final image
FROM amazoncorretto:17

# Set the working directory in the container
WORKDIR /app

# Copy the built jar files from the previous stage
COPY --from=builder /app/build/libs /app/build/libs

# Set author information and description
LABEL maintainer="Julian Rojas <julianrojasgeo@gmail.com>"
LABEL description="Docker image to test render deploy"

#Expose the image
EXPOSE 8080

# Set the command to run the application
CMD ["java", "-jar", "/app/build/libs/SB-docker-render-V0.1.jar"]
