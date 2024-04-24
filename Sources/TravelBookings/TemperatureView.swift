import SwiftUI

/// A widget that shows the current temperature for a given city
struct TemperatureView : View {
    let city: City
    @State var temperature = ""
    @AppStorage("celsius") var celsius: Bool = true

    var body: some View {
        Text(temperature)
            .font(.title2.bold())
            .task {
                do {
                    let temp = try await Weather.fetch(latitude: city.latitude, longitude: city.longitude).conditions.temperature
                    self.temperature = temp.temperatureString(celsius: celsius)
                } catch {
                    logger.error("error fetching temperature: \(error)")
                }
            }
    }
}

extension Double {
    /// Takes the current temperature (in celsius) and creates string description.
    func temperatureString(celsius: Bool, withUnit: Bool = true) -> String {
        // perform conversion if needed
        let temp = celsius ? self : ((self * 9/5) + 32)
        // Celsius temperatures are generally formatted with 1 decimal place, whereas Fahrenheit is not
        let fmt = String(format: "%.\(celsius ? 1 : 0)f", temp)
        return withUnit ? "\(fmt) °\(celsius ? "C" : "F")" : "\(fmt)°"
    }
}
