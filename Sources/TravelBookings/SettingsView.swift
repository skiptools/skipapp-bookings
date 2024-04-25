import SwiftUI

struct SettingsView : View {
    @Binding var appearance: String
    @AppStorage("celsius") var celsius: Bool = true
    @AppStorage("kilometers") var kilometers: Bool = true

    var body: some View {
        NavigationStack {
            Form {
                Section("Settings") {
                    Picker("Appearance", selection: $appearance) {
                        Text("System").tag("")
                        Text("Light").tag("light")
                        Text("Dark").tag("dark")
                    }

                    HStack {
                        Text("Fahrenheit / Celsius")
                        Spacer()
                        Text("\(Double(20.2).temperatureString(celsius: celsius))")
                            .font(.caption)
                        Toggle("Fahrenheit/Celsius Units", isOn: $celsius).labelsHidden()
                    }

                    HStack {
                        Text("Miles / Kilometers")
                        Spacer()
                        Text("\(Double(24).distanceString(kilometers: kilometers))")
                            .font(.caption)
                        Toggle("Miles/Kilometers Units", isOn: $kilometers).labelsHidden()
                    }
                }

                Section("Info") {
                    NavigationLink("Source Code") {
                        WebView(url: URL(string: "https://source.skip.tools/skipapp-bookings")!)
                            .navigationTitle(Text("Source"))
                            #if !os(macOS)
                            .navigationBarTitleDisplayMode(.inline)
                            #endif
                    }
                    HStack {
                        #if SKIP
                        ComposeView { ctx in // Mix in Compose code!
                            androidx.compose.material3.Text("💚", modifier: ctx.modifier)
                        }
                        #else
                        Text(verbatim: "💙")
                        #endif
                        Text("Powered by \(androidSDK != nil ? "Jetpack Compose" : "SwiftUI")")
                    }
                    .foregroundStyle(.gray)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
