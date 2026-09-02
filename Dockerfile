# https://github.com/cirruslabs/docker-images-android/pkgs/container/android-sdk
# https://github.com/cirruslabs/docker-images-android/blob/master/sdk/36/Dockerfile
ARG android_sdk_ver=36
FROM ghcr.io/cirruslabs/android-sdk:${android_sdk_ver}

ARG flutter_ver=3.47.2
ARG gradle_8_ver=8.14.5
ARG gradle_9_ver=9.7.1

# install Flutter
ENV FLUTTER_HOME=/usr/local/flutter \
    FLUTTER_VERSION=${flutter_ver} \
    PATH=$PATH:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:/opt/gradle/gradle-9/bin

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends --no-install-suggests \
            ca-certificates \
 && update-ca-certificates \
    \
 # install Flutter itself
 && curl -fL -o /tmp/flutter.tar.xz \
         https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${flutter_ver}-stable.tar.xz \
 && tar -xf /tmp/flutter.tar.xz -C /usr/local/ \
 && git config --global --add safe.directory /usr/local/flutter \
 && flutter config --enable-android \
                   --no-enable-ios \
 && flutter precache --universal --no-ios \
 && (yes | flutter doctor --android-licenses) \
 && flutter config --no-analytics \
 && flutter --version \
    \
 # Make Flutter tools available for non-root usage
 && chown -R 1000:1000 /usr/local/flutter/packages/flutter_tools/.dart_tool/ \
    \
 && rm -rf /var/lib/apt/lists/* \
           /tmp/*

# install gradle
RUN mkdir /opt/gradle \
    && wget https://services.gradle.org/distributions/gradle-${gradle_8_ver}-bin.zip \
    && unzip -d /opt/gradle gradle-${gradle_8_ver}-bin.zip \
    && ln -s /opt/gradle/gradle-${gradle_8_ver} /opt/gradle/gradle-8 \
    && wget https://services.gradle.org/distributions/gradle-${gradle_9_ver}-bin.zip \
    && unzip -d /opt/gradle gradle-${gradle_9_ver}-bin.zip \
    && ln -s /opt/gradle/gradle-${gradle_9_ver} /opt/gradle/gradle-9 \
    && mkdir /opt/gradle/wrapper \
    && cd /opt/gradle/wrapper \
    && printf 'pluginManagement { repositories { gradlePluginPortal(); mavenCentral(); google() } }\ndependencyResolutionManagement { repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS); repositories { mavenCentral(); google() } }\nrootProject.name = "temp"\n' > settings.gradle \
    && printf 'plugins { id("base") }\n' > build.gradle.kts \
    && gradle wrapper --gradle-version ${gradle_8_ver} \
    && ./gradlew \
    && gradle wrapper --gradle-version ${gradle_9_ver} \
    && ./gradlew

# update android sdk
RUN sdkmanager --uninstall "emulator" \
    && /opt/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager \
       "platforms;android-37.2" \
       "platforms;android-37.0" \
       "platforms;android-36" \
       "platforms;android-35" \
       "platforms;android-34" \
       "build-tools;37.0.0" \
       "build-tools;36.0.0" \
       "build-tools;35.0.0" \
       "build-tools;34.0.0" \
       "cmake;3.22.1" \       
       "ndk;28.2.13676358"

# work directory
WORKDIR /app