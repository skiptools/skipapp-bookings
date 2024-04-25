import Foundation

/// A City model
struct City : Identifiable, Codable {
    typealias ID = Int

    let id: ID
    var name: String
    let tagline: String
    let population: String
    let country: String
    let latitude: Double
    let longitude: Double
    let imageURL: URL
    let wikipediaURL: URL
}

extension City {
    /// Returns the distance in kilometers between the two latitude/longitude points using the Haversine formula
    func distance(to city: City) -> Double {
        let earthRadiusKilometers: Double = 6371

        let lat1 = self.latitude * .pi / 180
        let lat2 = self.latitude * .pi / 180
        let deltaLat = (city.latitude - self.latitude) * .pi / 180
        let deltaLon = (city.longitude - self.longitude) * .pi / 180

        let a = sin(deltaLat / 2) * sin(deltaLat / 2) + cos(lat1) * cos(lat2) * sin(deltaLon / 2) * sin(deltaLon / 2)
        let c = 2 * atan2(sqrt(a), sqrt(max(0.0, 1.0 - a)))

        return earthRadiusKilometers * c
    }
}
