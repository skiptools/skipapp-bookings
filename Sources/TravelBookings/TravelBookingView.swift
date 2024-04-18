import SwiftUI

struct TravelBookingView: View {
    let city: City
    let relatedCities: [City]
    @Binding var favorite: Bool
    @State var departure = Date()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0.0) {
                ZStack(alignment: .bottom) {
                    AsyncImage(url: city.imageURL) { image in
                        image.resizable().aspectRatio(contentMode: .fill).frame(height: 200).clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    Rectangle()
                        .fill(.linearGradient(colors: [Color.clear, Color.black.opacity(0.4)], startPoint: UnitPoint.top, endPoint: UnitPoint.bottom))
                    VStack {
                        Text(city.name).font(.largeTitle).bold()
                        Text(city.tagline).font(.title2)
                    }
                    .foregroundStyle(.white)
                    .padding()
                }
                .frame(height: 200)

                List {
                    Section {
                        CountryInfoSection()
                    }
                    Section("Related Destinations") {
                        ForEach(relatedCities, content: cityNavigationLink)
                    }
                }
            }
            .ignoresSafeArea(edges: .top)
            #if os(iOS)
            .toolbar(.hidden, for: .navigationBar)
            #endif
        }
    }


    fileprivate func cityNavigationLink(_ city: City) -> some View {
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
                    Text(city.name)
                    Text(city.tagline)
                }
            }
        }
    }


    fileprivate func CountryInfoSection() -> some View {
        Group {
            HStack {
                Text("Country")
                Spacer()
                Text(city.country)
            }
            HStack {
                Text("Population")
                Spacer()
                Text(city.population)
            }
            HStack {
                Text("Best weather")
                Spacer()
                Text(city.nicestMonth)
            }
            DatePicker("Departure", selection: $departure)
            Toggle("Favorite", isOn: $favorite)
        }
    }

}
