FROM runmymind/docker-android-sdk:latest

# install gradle
RUN wget https://services.gradle.org/distributions/gradle-6.1.1-bin.zip
RUN mkdir /opt/gradle
RUN unzip -d /opt/gradle gradle-6.1.1-bin.zip
RUN export PATH=$PATH:/opt/gradle/gradle-6.1.1/bin

# work directory
WORKDIR /app