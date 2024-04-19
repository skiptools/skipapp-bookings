import SwiftUI
import Foundation

public struct ContentView: View {
    @AppStorage("tab") var tab = Tab.cities
    @State var appearance = ""
    @ObservedObject var cityManager = CityManager.shared

    public init() {
    }

    public var body: some View {
        TabView(selection: $tab) {
            NavigationStack {
                CityListView(cityManager: cityManager, favorites: false)
                    .navigationTitle("Cities")
            }
                .tabItem { Label("Cities", systemImage: "list.bullet") }
                .tag(Tab.cities)

            NavigationStack {
                CityListView(cityManager: cityManager, favorites: true)
                    .navigationTitle("Favorites")
            }
                .tabItem { Label("Favorites", systemImage: "heart.fill") }
                .tag(Tab.favorites)

            SettingsView(appearance: $appearance)
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
                .tag(Tab.settings)
        }
        .preferredColorScheme(appearance == "dark" ? .dark : appearance == "light" ? .light : nil)
    }
}

enum Tab : String, Hashable {
    case cities, favorites, settings
}


#Preview {
    ContentView()
}
