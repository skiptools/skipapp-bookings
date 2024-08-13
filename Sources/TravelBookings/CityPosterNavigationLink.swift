import SwiftUI

/// A link to a city
struct CityPosterNavigationLink : View {
    let city: City

    var body: some View {
        NavigationLink(value: city.id) {
            ZStack(alignment: .bottom) {
                AsyncImage(url: city.imageURL) { image in
                    image.resizable().clipped()
                } placeholder: {
                    Rectangle()
                        .fill(.primary.opacity(0.1))
                }
                .aspectRatio(1, contentMode: .fill)

                Rectangle()
                    .fill(.linearGradient(colors: [.clear, .black.opacity(0.4)], startPoint: .center, endPoint: .bottom))

                Text(city.name).font(.title).bold()
                    .foregroundStyle(.white)
                    .padding()
            }
            .cornerRadius(20)
        }
    }
}
