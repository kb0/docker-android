FROM runmymind/docker-android-sdk:latest

# install gradle
RUN wget https://services.gradle.org/distributions/gradle-6.9-bin.zip && \
    mkdir /opt/gradle && \
    unzip -d /opt/gradle gradle-6.9-bin.zip

ENV PATH="/opt/gradle/gradle-6.9/bin:${PATH}"

# work directory
WORKDIR /app