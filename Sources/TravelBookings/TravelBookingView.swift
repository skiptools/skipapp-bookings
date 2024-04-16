// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import SwiftUI

struct TravelBookingView: View {
    let city: City
    let relatedCities: [City]
    @Binding var favorite: Bool

    var body: some View {
        VStack {
            Text(city.name).font(.largeTitle)
            Text(city.tagline).font(.title2)
            AsyncImage(url: city.imageURL) { image in
                image.resizable().aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 400)

            CityInfoView(city: city, favorite: $favorite)

            List {
                ForEach(relatedCities) { city in
                    NavigationLink(value: city.id) {
                        HStack {
                            AsyncImage(url: city.imageURL) { image in
                                image.resizable().clipped()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            VStack(alignment: .leading) {
                                Text(city.name)
                                Text(city.tagline)
                            }
                        }
                    }
                }
            }
        }
    }
}


struct CityInfoView : View {
    let city: City
    @Binding var favorite: Bool

    var body: some View {
        Form {
            HStack {
                Text("Country")
                Spacer()
                Text("\(city.country)")
            }
            HStack {
                Text("Population")
                Spacer()
                Text("\(city.population)")
            }
            HStack {
                Text("Best weather")
                Spacer()
                Text("\(city.nicestMonth)")
            }
//            Text("Latitude: \(city.latitude)")
//            Text("Longitude: \(city.longitude)")
            Toggle("Favorite", isOn: $favorite)
        }
    }
}
