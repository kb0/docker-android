FROM runmymind/docker-android-sdk:latest

# install gradle
RUN wget https://services.gradle.org/distributions/gradle-8.7-bin.zip && \
    mkdir /opt/gradle && \
    unzip -d /opt/gradle gradle-8.7-bin.zip

ENV PATH="/opt/gradle/gradle-8.7/bin:${PATH}"

# work directory
WORKDIR /app
