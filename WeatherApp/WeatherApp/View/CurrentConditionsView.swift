import SwiftUI

struct CurrentConditionsView: View {
    @StateObject private var viewModel = WeatherViewModel()
    let weather: CurrentWeather

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("City: \(weather.name)")
            Text("Temp: \(weather.main.temp, specifier: "%.1f")°C")
            Text("Feels like: \(weather.main.feels_like, specifier: "%.1f")°C")
            Text("Condition: \(weather.weather.first?.description ?? "N/A")")

            Image("few clouds")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(10)
        }
    }
}
