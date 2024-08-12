import SwiftUI

/// The top-level view of the app, containing the primary tabs
public struct ContentView: View {
    @AppStorage("tab") var tab = Tab.cities
    @State var cityListPath = NavigationPath()
    @State var appearance = ""
    @ObservedObject var cityManager = CityManager.shared

    public init() {
    }

    public var body: some View {
        TabView(selection: $tab) {
            NavigationStack(path: $cityListPath) {
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
        .onOpenURL { url in
            // travelbookings://<tab>/path
            if let tabName = url.host(), let tab = Tab(rawValue: tabName) {
                self.tab = tab
                if tab == .cities, let city = cityManager.allCities.first(where: { $0.name == url.lastPathComponent }) {
                    // Does not push city properly on iOS without async dispatch
                    DispatchQueue.main.async {
                        cityListPath.removeLast(cityListPath.count)
                        cityListPath.append(city.id)
                    }
                }
            }
        }
    }
}

enum Tab : String, Hashable {
    case cities, favorites, settings
}


#Preview {
    ContentView()
}
