# Travel

This is a demonstration of a full-featured
[Skip](https://skip.tools) dual-platform app project
for both iOS and Android. It is a travel exploration app
that displays cities loaded from a bundled JSON asset,
and has the following features:

  - a navigation list of the bundled city list
  - a persistent favorites list that can be modified and reordered
  - an embedded maps view for any given city
  - an embedded web view showing the wikipedia page for the city
  - dynamic temperature update using a weather web service endpoint
  - a settings view enabling override of preferred color scheme and display units
  
  iOS |  Android
:----:|:--------:
![iOS Screenshot](https://assets.skip.tools/skipapp-bookings/city-list-iphone.png) | ![Android Screenshot](https://assets.skip.tools/skipapp-bookings/city-list-android.png)

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

