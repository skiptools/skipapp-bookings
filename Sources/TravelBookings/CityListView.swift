import SwiftUI

struct CityListView : View {
    @ObservedObject var cityManager = CityManager.shared
    let favorites: Bool
    @State var searchText = ""

    var body: some View {
        let cities = matchingCities()
        if cities.isEmpty {
            (favorites ? Text("No Favorites") : Text("No Cities"))
                .font(.title)
        } else {
            List {
                ForEach(cities) { city in
                    CityNavigationLink(city: city)
                }
                .onDelete { indices in
                    for index in indices {
                        cityManager.favoriteIDs.remove(cities[index].id)
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationDestination(for: City.ID.self) { id in
                if let city = cities.first(where: { $0.id == id }) {
                    CityView(city: city, showMap: favorites, favorite: Binding(get: {
                        cityManager.favoriteIDs.contains(city.id)
                    }, set: { favorite in
                        if favorite {
                            cityManager.favoriteIDs.insert(city.id)
                        } else {
                            cityManager.favoriteIDs.remove(city.id)
                        }
                    }))
                }
            }
        }
    }

    private func matchingCities() -> [City] {
        return CityManager.shared.allCities.filter { city in
            if favorites && !CityManager.shared.favoriteIDs.contains(city.id) {
                return false
            }
            let words = city.name.split(separator: " ")
            let prefix = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            return words.contains { $0.lowercased().starts(with: prefix) }
        }
    }
}
