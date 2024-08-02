import SwiftUI

/// A searchable list of all the cities
struct CityListView : View {
    @State var searchText = ""
    @State var isGridView = false
    @EnvironmentObject var cityManager: CityManager

    func matchingCities() -> [City] {
        cityManager.allCities.filter { city in
            let words = city.name.split(separator: " ")
            let prefix = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            return words.contains { $0.lowercased().starts(with: prefix) }
        }
    }

    var body: some View {
        Group {
            if isGridView {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))]) {
                        ForEach(matchingCities()) { city in
                            CityPosterNavigationLink(city: city)
                        }
                    }
                    .padding()
                }
                .id(1)
                .transition(.opacity)
            } else {
                List {
                    ForEach(matchingCities()) { city in
                        CityListNavigationLink(city: city)
                    }
                }
                .id(2)
                .transition(.opacity)
            }
        }
        .searchable(text: $searchText)
        .navigationDestination(for: City.ID.self) { id in
            if let city = cityManager.allCities.first(where: { $0.id == id }) {
                CityView(city: city, showFavorites: true)
            }
        }
        .toolbar {
            Button(action: { withAnimation { isGridView = !isGridView } }) {
                Image(systemName: "line.3.horizontal")
            }
        }
    }
}
