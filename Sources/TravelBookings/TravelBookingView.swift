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
    @State var departure = Date()

    var body: some View {
        VStack(spacing: 0.0) {
            ZStack(alignment: .bottom) {
                AsyncImage(url: city.imageURL) { image in
                    image.resizable().aspectRatio(contentMode: .fill).frame(height: 200).clipped()
                } placeholder: {
                    ProgressView()
                }
                Rectangle()
                    .fill(.linearGradient(colors: [Color.clear, Color.black.opacity(0.4)], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1)))
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
                    DatePicker("Departure", selection: $departure)
                    Toggle("Favorite", isOn: $favorite)
                }
                Section("Related Destinations") {
                    ForEach(relatedCities) { city in
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
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}
