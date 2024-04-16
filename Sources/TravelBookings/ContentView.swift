// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import SwiftUI
import Foundation

/// True when running in a transpiled Java runtime environment
let isJava = ProcessInfo.processInfo.environment["java.io.tmpdir"] != nil
/// True when running within an Android environment (either an emulator or device)
let isAndroid = isJava && ProcessInfo.processInfo.environment["ANDROID_ROOT"] != nil
/// True is the transpiled code is currently running in the local Robolectric test environment
let isRobolectric = isJava && !isAndroid
/// True if the system's `Int` type is 32-bit.
let is32BitInteger = Int64(Int.max) == Int64(Int32.max)

struct City : Identifiable {
    let id: Int
    let name: String
    let tagline: String
    let population: String
    let nicestMonth: String
    let country: String
    let latitude: Double
    let longitude: Double
    let imageURL: URL
}

let cities = [
    City(id: 1, name: "New York", tagline: "The City That Never Sleeps", population: "8.4 million", nicestMonth: "July", country: "USA", latitude: 40.7128, longitude: -74.0060, imageURL: URL(string: "https://images.pexels.com/photos/1239162/pexels-photo-1239162.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")!),
    City(id: 2, name: "Paris", tagline: "The City of Lights", population: "2.2 million", nicestMonth: "July", country: "France", latitude: 48.8566, longitude: 2.3522, imageURL: URL(string: "https://images.pexels.com/photos/2363/france-landmark-lights-night.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")!),
    City(id: 3, name: "Tokyo", tagline: "The Land of the Rising Sun", population: "9.3 million", nicestMonth: "May", country: "Japan", latitude: 35.6895, longitude: 139.6917, imageURL: URL(string: "https://images.pexels.com/photos/2614818/pexels-photo-2614818.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")!),
    City(id: 4, name: "London", tagline: "The Capital of Culture", population: "9.1 million", nicestMonth: "July", country: "UK", latitude: 51.5074, longitude: -0.1278, imageURL: URL(string: "https://images.pexels.com/photos/427679/pexels-photo-427679.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")!),
    City(id: 5, name: "Rome", tagline: "The Eternal City", population: "2.7 million", nicestMonth: "July", country: "Italy", latitude: 41.9028, longitude: 12.4964, imageURL: URL(string: "https://images.pexels.com/photos/1797161/pexels-photo-1797161.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")!),
    City(id: 6, name: "Barcelona", tagline: "The City of Gaudí", population: "1.6 million", nicestMonth: "July", country: "Spain", latitude: 41.3851, longitude: 2.1734, imageURL: URL(string: "https://images.pexels.com/photos/1388030/pexels-photo-1388030.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")!),
    City(id: 7, name: "Sydney", tagline: "The Harbour City", population: "5.3 million", nicestMonth: "December", country: "Australia", latitude: -33.8688, longitude: 151.2093, imageURL: URL(string: "https://images.pexels.com/photos/1619854/pexels-photo-1619854.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")!),
//    City(id: 8, name: "Moscow", tagline: "The Capital of Russia", population: "12.6 million", nicestMonth: "July", country: "Russia", latitude: 55.7512, longitude: 37.6184, imageURL: URL(string: "XXX")!),
//    City(id: 9, name: "Cape Town", tagline: "The Mother City", population: "3.9 million", nicestMonth: "December", country: "South Africa", latitude: -33.9249, longitude: 18.4241, imageURL: URL(string: "XXX")!),
//    City(id: 10, name: "Bangkok", tagline: "The City of Angels", population: "8.7 million", nicestMonth: "February", country: "Thailand", latitude: 13.7563, longitude: 100.5018, imageURL: URL(string: "XXX")!),
//    City(id: 11, name: "Toronto", tagline: "The Good City", population: "2.7 million", nicestMonth: "July", country: "Canada", latitude: 43.6532, longitude: -79.3832, imageURL: URL(string: "XXX")!),
//    City(id: 12, name: "Lisbon", tagline: "The City of Seven Hills", population: "520,000", nicestMonth: "July", country: "Portugal", latitude: 38.7223, longitude: -9.1393, imageURL: URL(string: "XXX")!),
//    City(id: 13, name: "Dubai", tagline: "The City of Gold", population: "2 million"8 million", nicestMonth: "January", country: "UAE", latitude: 25.276987, longitude: 55.296249, imageURL: URL(string: "XXX")!),
//    City(id: 14, name: "Singapore", tagline: "The Lion City", population: "5.9 million", nicestMonth: "February", country: "Singapore", latitude: 1.3521, longitude: 103.8198, imageURL: URL(string: "XXX")!),
//    City(id: 15, name: "Hong Kong", tagline: "The Pearl of the Orient", population: "7.4 million", nicestMonth: "May", country: "China", latitude: 22.2875, longitude: 114.1588, imageURL: URL(string: "XXX")!),
//    City(id: 16, name: "Melbourne", tagline: "The City of Culture", population: "4.7 million", nicestMonth: "December", country: "Australia", latitude: -37.8136, longitude: 144.9631, imageURL: URL(string: "XXX")!),
//    City(id: 17, name: "Berlin", tagline: "The City of the Future", population: "3.7 million", nicestMonth: "July", country: "Germany", latitude: 52.5200, longitude: 13.4050, imageURL: URL(string: "XXX")!),
//    City(id: 18, name: "Amsterdam", tagline: "The Venice of the North", population: "850,000", nicestMonth: "July", country: "Netherlands", latitude: 52.3731, longitude: 4.8922, imageURL: URL(string: "XXX")!),
//    City(id: 19, name: "Vancouver", tagline: "The City of the Mountains", population: "2.4 million", nicestMonth: "July", country: "Canada", latitude: 49.2827, longitude: -123.1207, imageURL: URL(string: "XXX")!),
//    City(id: 20, name: "Buenos Aires", tagline: "The Paris of South America", population: "3.1 million", nicestMonth: "December", country: "Argentina", latitude: -34.6037, longitude: -58.3816, imageURL: URL(string: "XXX")!),
//    City(id: 21, name: "São Paulo", tagline: "The City of Brotherly Love", population: "12.3 million", nicestMonth: "February", country: "Brazil", latitude: -23.5505, longitude: -46.6333, imageURL: URL(string: "XXX")!),
//    City(id: 22, name: "Taipei", tagline: "The City of the Dragon", population: "7.3 million", nicestMonth: "May", country: "Taiwan", latitude: 25.0329, longitude: 121.5654, imageURL: URL(string: "XXX")!),
//    City(id: 23, name: "Istanbul", tagline: "The City of a Thousand Minarets", population: "15.5 million", nicestMonth: "July", country: "Turkey", latitude: 41.0082, longitude: 28.9784, imageURL: URL(string: "XXX")!),
//    City(id: 24, name: "Mexico City", tagline: "The Heart of Mexico", population: "21.7 million", nicestMonth: "February", country: "Mexico", latitude: 19.4326, longitude: -99.1332, imageURL: URL(string: "XXX")!),
//    City(id: 25, name: "Dublin", tagline: "The Emerald Isle", population: "1.3 million", nicestMonth: "July", country: "Ireland", latitude: 53.3498, longitude: -6.2603, imageURL: URL(string: "XXX")!),
//    City(id: 26, name: "Las Vegas", tagline: "The Entertainment Capital of the World", population: 650000, nicestMonth: "October", country: "USA", latitude: 36.1699, longitude: -115.1398, imageURL: URL(string: "XXX")!),
//    City(id: 27, name: "Rio de Janeiro", tagline: "The City of Love", population: "6.6 million", nicestMonth: "February", country: "Brazil", latitude: -22.9068, longitude: -43.1729, imageURL: URL(string: "XXX")!),
//    City(id: 28, name: "Cairo", tagline: "The City of a Thousand Minarets", population: "20.9 million", nicestMonth: "January", country: "Egypt", latitude: 30.0444, longitude: 31.2357, imageURL: URL(string: "XXX")!),
]


public struct ContentView: View {
    @AppStorage("tab") var tab = Tab.welcome
    @AppStorage("name") var name = "Skipper"
    @State var appearance = ""
    @State var isBeating = false

    public init() {
    }

    public var body: some View {
        TabView(selection: $tab) {
            TravelBookingView(city: isAndroid ? cities[2] : cities[1], relatedCities: cities.dropFirst(3).shuffled(), favorite: .constant(true))


//            VStack(spacing: 0) {
//                Text("Hello \(name)!")
//                    .padding()
//                Image(systemName: "heart.fill")
//                    .foregroundStyle(.red)
//                    .scaleEffect(isBeating ? 1.5 : 1.0)
//                    .animation(.easeInOut(duration: 1).repeatForever(), value: isBeating)
//                    .onAppear { isBeating = true }
//            }
//            .font(.largeTitle)
            .tabItem { Label("Favorites", systemImage: "heart.fill") }
            .tag(Tab.welcome)

            NavigationStack {
                List {
                    ForEach(1..<1_000) { i in
                        NavigationLink("Item \(i)", value: i)
                    }
                }
                .navigationTitle("Home")
                .navigationDestination(for: Int.self) { i in
                    Text("Item \(i)")
                        .font(.title)
                        .navigationTitle("Screen \(i)")
                }
            }
            .tabItem { Label("Home", systemImage: "house.fill") }
            .tag(Tab.home)

            NavigationStack {
                Form {
                    TextField("Name", text: $name)
                    Picker("Appearance", selection: $appearance) {
                        Text("System").tag("")
                        Text("Light").tag("light")
                        Text("Dark").tag("dark")
                    }
                    HStack {
                        #if SKIP
                        ComposeView { ctx in // Mix in Compose code!
                            androidx.compose.material3.Text("💚", modifier: ctx.modifier)
                        }
                        #else
                        Text(verbatim: "💙")
                        #endif
                        Text("Powered by \(androidSDK != nil ? "Jetpack Compose" : "SwiftUI")")
                    }
                    .foregroundStyle(.gray)
                }
                .navigationTitle("Settings")
            }
            .tabItem { Label("Settings", systemImage: "gearshape.fill") }
            .tag(Tab.settings)
        }
        .preferredColorScheme(appearance == "dark" ? .dark : appearance == "light" ? .light : nil)
    }
}

enum Tab : String, Hashable {
    case welcome, home, settings
}

#Preview {
    ContentView()
}
