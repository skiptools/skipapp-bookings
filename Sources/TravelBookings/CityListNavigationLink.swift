import SwiftUI

/// A link to a city
struct CityListNavigationLink : View {
    let city: City
    var fromCity: City? = nil
    @AppStorage("kilometers") var kilometers: Bool = true

    var body: some View {
        NavigationLink(value: city.id) {
            HStack {
                AsyncImage(url: city.imageURL) { image in
                    image.resizable().clipped()
                } placeholder: {
                    Color.primary.opacity(0.1)
                }
                .cornerRadius(8)
                .frame(width: 50, height: 50)

                VStack(alignment: .leading) {
                    Text(verbatim: "\(city.name), \(city.country)")

                    if let fromCity = fromCity {
                        // if we are displaying this city relative from another, show the distance
                        Text(fromCity.distance(to: city).distanceString(kilometers: kilometers))
                    } else {
                        // otherwise show the city's tagline
                        Text(city.tagline)
                    }
                }

            }
            .lineLimit(1)
        }
    }
}

extension Double {
    /// Takes the current distance (in kilometers) and creates a string description of miles vs. kilometers
    func distanceString(kilometers: Bool) -> String {
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        let numstr = fmt.string(from: Int(kilometers ? (self) : (self / 1.60934)) as NSNumber)!
        return numstr + (kilometers ? " km" : " mi")
    }
}
