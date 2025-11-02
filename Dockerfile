FROM instrumentisto/flutter:3.35.7-androidsdk35-r0

# install gradle
RUN mkdir /opt/gradle

RUN wget https://services.gradle.org/distributions/gradle-8.10.2-bin.zip && \
    unzip -d /opt/gradle gradle-8.10.2-bin.zip
    
RUN wget https://services.gradle.org/distributions/gradle-8.14.3-bin.zip && \
    unzip -d /opt/gradle gradle-8.14.3-bin.zip

ENV PATH="/opt/gradle/gradle-8.14.3/bin:${PATH}"

# update android sdk
RUN /opt/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager \
  "platforms;android-34" \
  "platforms;android-35" \
  "platforms;android-36" \
  "cmake;3.22.1" \
  "ndk;26.3.11579264" \
  "ndk;27.0.12077973"

# work directory
WORKDIR /app