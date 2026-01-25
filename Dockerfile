FROM instrumentisto/flutter:3.38.7-androidsdk36-r0

# install gradle
RUN mkdir /opt/gradle

RUN wget https://services.gradle.org/distributions/gradle-8.10.2-bin.zip && \
    unzip -d /opt/gradle gradle-8.10.2-bin.zip

RUN wget https://services.gradle.org/distributions/gradle-8.14.4-bin.zip && \
    unzip -d /opt/gradle gradle-8.14.4-bin.zip

RUN wget https://services.gradle.org/distributions/gradle-9.2.1-bin.zip && \
    unzip -d /opt/gradle gradle-9.2.1-bin.zip

ENV PATH="/opt/gradle/gradle-8.14.4/bin:${PATH}"

# update android sdk
RUN /opt/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager \
  "platform-tools" \
  "platforms;android-35" \
  "build-tools;35.0.0" \
  "build-tools;35.0.1" \
  "platforms;android-36" \
  "build-tools;36.0.0" \
  "build-tools;36.1.0" \
  "ndk;28.2.13676358" \
  "cmake;3.22.1"

# work directory
WORKDIR /app