import Foundation
import SwiftUI

/// A manager for loading the cities list and handling user favorites
class CityManager : ObservableObject {
    /// The JSON list of cities stored with the app
    static let localCitiesURL: URL = Bundle.module.url(forResource: "Cities", withExtension: "json")!

    /// The JSON containing the user-selected list of favorite city IDs
    static let favoritesURL: URL = URL.documentsDirectory.appendingPathComponent("favorites.json")

    /// The app-wide singleton `CityManager`
    static let shared = CityManager()

    private init() {
        do {
            logger.log("localCitiesURL: \(Self.localCitiesURL)")
            logger.log("favoritesURL: \(Self.favoritesURL)")

            // load cities from Cities.json bundled with the app
            self.allCities = try JSONDecoder().decode([City].self, from: Data(contentsOf: Self.localCitiesURL)).sorted { c1, c2 in
                c1.name < c2.name
            }
            logger.log("loaded cities: \(self.allCities.count)")

            // load favorites from favorites.json in the user's app documents folder
            self.favoriteIDs = try JSONDecoder().decode(Array<City.ID>.self, from: Data(contentsOf: Self.favoritesURL))
            logger.log("loaded favorites: \(self.favoriteIDs)")
        } catch {
            logger.log("error initializing CityManager: \(error)")
        }
    }

    /// All the cities in the list
    @Published var allCities: [City] = []

    /// The ordered list of favorites specified by the user; changed will be persisted to the JSON file
    @Published var favoriteIDs: Array<City.ID> = [] {
        didSet {
            logger.log("saving favorites: \(self.favoriteIDs)")
            do {
                try JSONEncoder().encode(favoriteIDs).write(to: Self.favoritesURL)
            } catch {
                logger.log("error saving favorites: \(error)")
            }
        }
    }

    /// Returns the ordered list of cities that are in the favorites list.
    ///
    /// - Complexity: O(n \* m) (i.e., do not use on large lists)
    var favoriteCities: [City] {
        favoriteIDs.compactMap { id in
            allCities.first { c in
                c.id == id
            }
        }
    }

    /// Simply returns the list of cities ordered by distance from this city
    func citiesClosest(to city: City) -> [City] {
        allCities
            .filter { c in
                c.id != city.id
            }
            .sorted { c1, c2 in
                c1.distance(to: city) < c2.distance(to: city)
            }
    }

    /// Returns a binding that will add or remove a given city from the favorites list
    func favoriteBinding(for city: City) -> Binding<Bool> {
        Binding(get: {
            self.favoriteIDs.contains(city.id)
        }, set: { isFavorite in
            if isFavorite {
                self.favoriteIDs.append(city.id)
            } else {
                self.favoriteIDs = self.favoriteIDs.filter({ $0 != city.id })
            }
        })
    }
}
