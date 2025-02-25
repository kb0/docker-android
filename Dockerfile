FROM instrumentisto/flutter:3.29.0-androidsdk34-r0

# install gradle
RUN wget https://services.gradle.org/distributions/gradle-8.10-bin.zip && \
    mkdir /opt/gradle && \
    unzip -d /opt/gradle gradle-8.10-bin.zip

ENV PATH="/opt/gradle/gradle-8.10/bin:${PATH}"

# update android sdk
RUN /opt/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager "cmake;3.22.1" "platforms;android-35" "ndk;26.3.11579264" "ndk;27.0.12077973"

# work directory
WORKDIR /app