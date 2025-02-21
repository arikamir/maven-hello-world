FROM openjdk:11-jre-slim-bullseye AS build
ARG TAG=v1.0.0
ENV TAG=$TAG

# Add debian security repositories
RUN echo "deb http://deb.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list && \
    echo "deb http://security.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list

# Update system and install required packages with explicit glibc version
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    coreutils \
    libc-bin=2.31-13+deb11u11 \
    libc6=2.31-13+deb11u11 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN wget -q "https://github.com/arikamir/maven-hello-world/releases/download/v$TAG/my-app-$TAG.jar" -O "my-app-$TAG.jar" \
    && wget -q "https://github.com/arikamir/maven-hello-world/releases/download/v$TAG/my-app-$TAG.jar.sha256" -O "my-app-$TAG.jar.sha256"

RUN sha256sum -c "my-app-$TAG.jar.sha256" 
RUN mv "my-app-$TAG.jar" "my-app.jar"

FROM build AS test
    # If you have a way to test the downloaded JAR, do it here. 
    # For instance, if the JAR itself can run tests or you have an integration script:
    RUN java -jar "my-app.jar" --test
    # (If there is no test step, you can omit this stage.)

FROM openjdk:11-jre-slim-bullseye

# Add debian security repositories
RUN echo "deb http://deb.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list && \
    echo "deb http://security.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list

# Update system and install required glibc version
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libc-bin=2.31-13+deb11u11 \
    libc6=2.31-13+deb11u11 && \
    rm -rf /var/lib/apt/lists/*

RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

WORKDIR /app
COPY --from=build /app/my-app.jar /app/app.jar

USER appuser

ENTRYPOINT ["java", "-jar", "app.jar"]