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
    /// Returns the distance in meters between the two latitude/longitude points using the Haversine formula
    func distance(to city: City) -> Double {
        let earthRadius: Double = 6371e3

        let lat1 = self.latitude * .pi / 180
        let lat2 = self.latitude * .pi / 180
        let deltaLat = (city.latitude - self.latitude) * .pi / 180
        let deltaLon = (city.longitude - self.longitude) * .pi / 180

        let a = sin(deltaLat / 2) * sin(deltaLat / 2) + cos(lat1) * cos(lat2) * sin(deltaLon / 2) * sin(deltaLon / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))

        return earthRadius * c
    }
}

extension Double {
    /// Takes the current distance (in kilometers) and creates a string description of miles vs. kilometers
    func distanceString(kilometers: Bool) -> String {
        return Int64(kilometers ? (self) : (self / 1.60934)).description
    }
}
