# HelloSkip

This is a [Skip](https://skip.tools) dual-platform app project.
It builds a native app for both iOS and Android.

## Building

This project is both a stand-alone Swift Package Manager module,
as well as an Xcode project that builds and transpiles the project
into a Kotlin Gradle project for Android using the Skip plugin.

Building the module requires that Skip be installed using
[Homebrew](https://brew.sh) with `brew install skiptools/skip/skip`.

This will also install the necessary transpiler prerequisites:
Kotlin, Gradle, and the Android build tools.

Installation prerequisites can be confirmed by running `skip checkup`.

## Testing

The module can be tested using the standard `swift test` command
or by running the test target for the macOS destination in Xcode,
which will run the Swift tests as well as the transpiled
Kotlin JUnit tests in the Robolectric Android simulation environment.

Parity testing can be performed with `skip test`,
which will output a table of the test results for both platforms.

## Running

Xcode and Android Studio must be downloaded and installed in order to
run the app in the iOS simulator / Android emulator.
An Android emulator must already be running, which can be launched from 
Android Studio's Device Manager.

To run both the Swift and Kotlin apps simultaneously, 
launch the HelloSkipApp target from Xcode.
A build phases runs the "Launch Android APK" script that
will deploy the transpiled app a running Android emulator or connected device.
Logging output for the iOS app can be viewed in the Xcode console, and in
Android Studio's logcat tab for the transpiled Kotlin app.

## Project Structure

```plaintext
.
├── Android
│   ├── app
│   │   ├── build.gradle.kts
│   │   ├── proguard-rules.pro
│   │   └── src
│   │       └── main
│   │           ├── AndroidManifest.xml
│   │           ├── kotlin
│   │           │   └── hello
│   │           │       └── skip
│   │           │           └── Main.kt
│   │           └── res
│   │               ├── mipmap-hdpi
│   │               │   └── ic_launcher.png
│   │               ├── mipmap-mdpi
│   │               │   └── ic_launcher.png
│   │               ├── mipmap-xhdpi
│   │               │   └── ic_launcher.png
│   │               ├── mipmap-xxhdpi
│   │               │   └── ic_launcher.png
│   │               └── mipmap-xxxhdpi
│   │                   └── ic_launcher.png
│   ├── gradle
│   │   └── wrapper
│   │       └── gradle-wrapper.properties
│   ├── gradle.properties
│   └── settings.gradle.kts
├── Darwin
│   ├── Assets.xcassets
│   │   ├── AccentColor.colorset
│   │   │   └── Contents.json
│   │   ├── AppIcon.appiconset
│   │   │   ├── AppIcon-20@2x.png
│   │   │   ├── AppIcon-20@2x~ipad.png
│   │   │   ├── AppIcon-20@3x.png
│   │   │   ├── AppIcon-20~ipad.png
│   │   │   ├── AppIcon-29.png
│   │   │   ├── AppIcon-29@2x.png
│   │   │   ├── AppIcon-29@2x~ipad.png
│   │   │   ├── AppIcon-29@3x.png
│   │   │   ├── AppIcon-29~ipad.png
│   │   │   ├── AppIcon-40@2x.png
│   │   │   ├── AppIcon-40@2x~ipad.png
│   │   │   ├── AppIcon-40@3x.png
│   │   │   ├── AppIcon-40~ipad.png
│   │   │   ├── AppIcon-83.5@2x~ipad.png
│   │   │   ├── AppIcon@2x.png
│   │   │   ├── AppIcon@2x~ipad.png
│   │   │   ├── AppIcon@3x.png
│   │   │   ├── AppIcon~ios-marketing.png
│   │   │   ├── AppIcon~ipad.png
│   │   │   └── Contents.json
│   │   └── Contents.json
│   ├── Entitlements.plist
│   ├── HelloSkip.xcconfig
│   ├── HelloSkip.xcodeproj
│   │   ├── project.pbxproj
│   │   ├── project.xcworkspace
│   │   │   └── xcshareddata
│   │   │       └── swiftpm
│   │   │           ├── Package.resolved
│   │   │           └── configuration
│   │   └── xcuserdata
│   │       └── marc.xcuserdatad
│   │           └── xcschemes
│   │               └── xcschememanagement.plist
│   └── Sources
│       └── HelloSkipAppMain.swift
├── Package.swift
├── README.md
├── Skip.env
├── Sources
│   └── HelloSkip
│       ├── ContentView.swift
│       ├── HelloSkip.swift
│       ├── HelloSkipApp.swift
│       ├── Resources
│       │   └── Localizable.xcstrings
│       └── Skip
│           └── skip.yml
└── Tests
    └── HelloSkipTests
        ├── HelloSkipTests.swift
        ├── Resources
        │   └── TestData.json
        ├── Skip
        │   └── skip.yml
        └── XCSkipTests.swift
```
