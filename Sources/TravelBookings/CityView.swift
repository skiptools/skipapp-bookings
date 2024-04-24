import SwiftUI
import Foundation

/// An overview of a City
struct CityView: View {
    let city: City
    let showFavorites: Bool
    @State var departure = Date()
    @EnvironmentObject var cityManager: CityManager

    var body: some View {
        VStack(spacing: 0.0) {
            ZStack(alignment: .center) {
                AsyncImage(url: city.imageURL) { image in
                    image.resizable().aspectRatio(contentMode: .fill).frame(height: 200).clipped()
                } placeholder: {
                    ProgressView()
                }

                Rectangle()
                    .fill(.linearGradient(colors: [.clear, .black.opacity(0.4)], startPoint: .top, endPoint: .bottom))

                VStack {
                    Spacer()
                    Text(city.name).font(.largeTitle).bold()
                    Text(city.tagline).font(.title2)
                }
                .foregroundStyle(.white)
                .padding()

                HStack {
                    DismissButton().padding()
                    Spacer()
                    TemperatureView(city: city).padding()
                }
                .foregroundStyle(.white)
            }
            .frame(height: 200)

            List {
                Section {
                    CountryInfoSection()
                }
                Section("Nearest Cities") {
                    ForEach(cityManager.citiesClosest(to: city), content: { CityNavigationLink(city: $0) })
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        #if SKIP || os(iOS)
        .toolbar(.hidden, for: .navigationBar)
        #endif
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

            DatePicker("Departure", selection: $departure)

            if showFavorites {
                Toggle("Favorite", isOn: cityManager.favoriteBinding(for: city))
            }

            NavigationLink("Map") {
                MapView(latitude: city.latitude, longitude: city.longitude)
                    .navigationTitle(Text(city.name))
                    #if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
                    #endif
            }

            NavigationLink("Wikipedia") {
                WebView(url: city.wikipediaURL)
                    .navigationTitle(Text(city.name))
                    #if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
                    #endif
            }

        }
    }
}
