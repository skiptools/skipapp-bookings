import SwiftUI

/// A searchable list of all the cities
struct CityListView : View {
    @State var searchText = ""
    @EnvironmentObject var cityManager: CityManager

    func matchingCities() -> [City] {
        cityManager.allCities.filter { city in
            let words = city.name.split(separator: " ")
            let prefix = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            return words.contains { $0.lowercased().starts(with: prefix) }
        }
    }

    var body: some View {
        List {
            ForEach(matchingCities()) { city in
                CityNavigationLink(city: city)
            }
        }
        .searchable(text: $searchText)
        .navigationDestination(for: City.ID.self) { id in
            if let city = cityManager.allCities.first(where: { $0.id == id }) {
                CityView(city: city, showFavorites: true)
            }
        }
    }
}
