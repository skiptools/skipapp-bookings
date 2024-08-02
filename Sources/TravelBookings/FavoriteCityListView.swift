import SwiftUI

/// An editable list of favorite cities
struct FavoriteCityListView : View {
    @EnvironmentObject var cityManager: CityManager

    var body: some View {
        if cityManager.favoriteIDs.isEmpty {
            Text("No Favorites")
                .font(.title)
        } else {
            List {
                ForEach(cityManager.favoriteCities) { city in
                    CityListNavigationLink(city: city)
                }
                .onMove(perform: { indices, i in
                    cityManager.favoriteIDs.move(fromOffsets: indices, toOffset: i)
                })
                .onDelete { indices in
                    cityManager.favoriteIDs.remove(atOffsets: indices)
                }
            }
            .navigationDestination(for: City.ID.self) { id in
                if let city = cityManager.allCities.first(where: { $0.id == id }) {
                    CityView(city: city, showFavorites: false)
                }
            }
        }
    }
}
