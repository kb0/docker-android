FROM instrumentisto/flutter:3.38.4-androidsdk36-r0

# install gradle
RUN mkdir /opt/gradle

RUN wget https://services.gradle.org/distributions/gradle-8.10.2-bin.zip && \
    unzip -d /opt/gradle gradle-8.10.2-bin.zip
    
RUN wget https://services.gradle.org/distributions/gradle-8.14.3-bin.zip && \
    unzip -d /opt/gradle gradle-8.14.3-bin.zip

ENV PATH="/opt/gradle/gradle-8.14.3/bin:${PATH}"

# update android sdk
RUN /opt/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager \
  "platform-tools" \
  "platforms;android-35" \
  "build-tools;35.0.0" \
  "build-tools;35.0.1" \
  "platforms;android-36" \
  "build-tools;36.0.0" \
  "build-tools;36.1.0" \
  "ndk;27.0.12077973" \
  "ndk;28.1.13356709" \
  "cmake;3.22.1"

# work directory
WORKDIR /app