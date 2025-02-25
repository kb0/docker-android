FROM instrumentisto/flutter:3.29.0-androidsdk34-r0

/opt/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager "cmake;3.22.1"
/opt/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager "platforms;android-32"
/opt/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager "platforms;android-35"
/opt/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager "ndk;26.3.11579264"
/opt/android-sdk-linux/cmdline-tools/latest/bin/sdkmanager "ndk;27.0.12077973"