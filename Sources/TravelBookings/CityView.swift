import SwiftUI
import Foundation

struct CityView: View {
    let city: City
    var showMap: Bool
    @Binding var favorite: Bool
    @State var departure = Date()

    var body: some View {
        VStack(spacing: 0.0) {
            ZStack(alignment: .center) {
                AsyncImage(url: city.imageURL) { image in
                    image.resizable().aspectRatio(contentMode: .fill).frame(height: 200).clipped()
                } placeholder: {
                    ProgressView()
                }
                Rectangle()
                    .fill(.linearGradient(colors: [Color.clear, Color.black.opacity(0.4)], startPoint: UnitPoint.top, endPoint: UnitPoint.bottom))
                VStack {
                    Spacer()
                    Text(city.name).font(.largeTitle).bold()
                    Text(city.tagline).font(.title2)
                }
                .foregroundStyle(.white)
                .padding()

                DismissButton()
            }
            .frame(height: 200)

            if showMap {
                MapView(latitude: city.latitude, longitude: city.longitude)
            } else {
                List {
                    Section {
                        CountryInfoSection()
                    }
                    Section("Related Destinations") {
                        ForEach(city.relatedCities ?? [], content: { CityNavigationLink(city: $0) })
                    }
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
            Toggle("Favorite", isOn: $favorite)
            NavigationLink("Wikipedia") {
                WebView(url: city.wikipediaURL)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle(Text(city.name))
            }

        }
    }
}

struct DismissButton : View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        HStack(alignment: .center) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundStyle(.white)
            }
            .padding()

            Spacer()
        }
    }
}

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
                    Text(city.name)
                    Text(city.tagline)
                }
            }
        }
    }
}
