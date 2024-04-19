import Foundation
import SwiftUI

private let favoritesURL = URL.documentsDirectory.appendingPathComponent("favorites.json")

class CityManager : ObservableObject {
    static let shared = CityManager()
    /// The location of the JSON document that stores the favorites

    @Published var allCities: [City] = cities
    @Published var favoriteIDs: Set<City.ID> = [] {
        didSet {
            logger.log("saving favorites: \(self.favoriteIDs)")
            do {
                try JSONEncoder().encode(favoriteIDs).write(to: favoritesURL)
            } catch {
                logger.log("error saving favorites: \(error)")
            }
        }
    }

    private init() {
        do {
            self.favoriteIDs = Set(try JSONDecoder().decode(Array<City.ID>.self, from: Data(contentsOf: favoritesURL)))
            logger.log("loaded favorites: \(self.favoriteIDs)")
        } catch {
            logger.log("error loading favorites: \(error)")
        }
    }
}


struct City : Identifiable, Codable {
    typealias ID = Int

    let id: ID
    let name: String
    let tagline: String
    let population: String
    let nicestMonth: String
    let country: String
    let latitude: Double
    let longitude: Double
    let imageURL: URL
    var relatedCities: [City]?
}

fileprivate let localCities: [City] = try! JSONDecoder().decode([City].self, from: Data(contentsOf: Bundle.module.url(forResource: "Cities", withExtension: "json")!))

let cities: [City] = localCities.shuffled().map({ c in
    var city = c
    city.relatedCities = localCities.shuffled()
    return city
})

let citiesSorted: [City] = cities.sorted { c1, c2 in
    c1.name < c2.name
}
