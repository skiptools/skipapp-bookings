import SwiftUI

public struct ContentView: View {
    @AppStorage("tab") var tab = Tab.cities
    @State var appearance = ""
    @ObservedObject var cityManager = CityManager.shared

    public init() {
    }

    public var body: some View {
        TabView(selection: $tab) {
            NavigationStack {
                CityListView()
                    .navigationTitle("Cities")
            }
                .tabItem { Label("Cities", systemImage: "list.bullet") }
                .tag(Tab.cities)

            NavigationStack {
                FavoriteCityListView()
                    .navigationTitle("Favorites")
            }
                .tabItem { Label("Favorites", systemImage: "heart.fill") }
                .tag(Tab.favorites)

            SettingsView(appearance: $appearance)
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
                .tag(Tab.settings)
        }
        .environmentObject(cityManager)
        .preferredColorScheme(appearance == "dark" ? .dark : appearance == "light" ? .light : nil)
    }
}

enum Tab : String, Hashable {
    case cities, favorites, settings
}


#Preview {
    ContentView()
}
