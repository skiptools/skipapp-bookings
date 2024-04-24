import SwiftUI

/// A link to a city
struct CityNavigationLink : View {
    let city: City

    var body: some View {
        NavigationLink(value: city.id) {
            HStack {
                AsyncImage(url: city.imageURL) { image in
                    image.resizable().clipped()
                } placeholder: {
                    ProgressView()
                }
                .cornerRadius(8)
                .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("\(city.name), \(city.country)")
                    Text(city.tagline)
                }
            }
        }
    }
}
