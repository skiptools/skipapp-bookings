import SwiftUI

struct SettingsView : View {
    @Binding var appearance: String

    var body: some View {
        NavigationStack {
            Form {
                Section("Settings") {
                    Picker("Appearance", selection: $appearance) {
                        Text("System").tag("")
                        Text("Light").tag("light")
                        Text("Dark").tag("dark")
                    }
                }

                Section("Info") {
                    NavigationLink("Source Code") {
                        WebView(url: URL(string: "https://source.skip.tools/skipapp-bookings")!)
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationTitle(Text("Source"))
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
