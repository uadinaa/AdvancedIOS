import SwiftUI

struct WeatherAlertsView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        VStack {
            Text("Weather Alerts")
                .font(.headline)
                .padding()

            if viewModel.weatherAlerts.isEmpty {
                Text("No active weather alerts")
                    .padding()
            } else {
                List(viewModel.weatherAlerts) { alert in
                    VStack(alignment: .leading) {
                        Text(alert.event)
                            .font(.title3)
                            .foregroundColor(.red)
                        Text(alert.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("From: \(Date(timeIntervalSince1970: TimeInterval(alert.start))) To: \(Date(timeIntervalSince1970: TimeInterval(alert.end)))")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.fetchWeatherAlerts(lat: 43.24, lon: 76.9)
        }
    }
}

