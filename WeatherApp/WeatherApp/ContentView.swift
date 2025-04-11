import SwiftUI
import CoreLocation


struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Section {
                        VStack(alignment: .leading) {
                            Text("Current Conditions")
                                .font(.headline)
                            
                            switch viewModel.loadingState {
                            case .idle, .loading:
                                ProgressView("loading...")
                                
                            case .success:
                                if let weather = viewModel.currentWeather {
                                    CurrentConditionsView(weather: weather)
                                }
                                
                            case .failed:
                                Text(viewModel.errorMessage ?? "Unknown error")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                    }
                    
                    Section {
                        VStack(alignment: .leading) {
                            Text("5-Day Forecast")
                                .font(.headline)
                            
                            switch viewModel.forecastState {
                            case .idle, .loading:
                                ProgressView("loading...")
                                
                            case .success:
                                if let forecastList = viewModel.forecast?.list {
                                    ForecastView(forecastList: forecastList)
                                }
                                
                            case .failed:
                                Text("Failed to load forecast")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                    }
                    
                    Section {
                        VStack(alignment: .leading) { 
                            Text("Air Quality")
                                .font(.headline)
                            
                            switch viewModel.loadingState {
                            case .idle, .loading:
                                ProgressView("loading...")
                                
                            case .success:
                                if let airQuality = viewModel.airQuality {
                                    if let aqi = airQuality.list.first?.main.aqi {
                                        Text("AQI: \(aqi)")
                                            .font(.subheadline)
                                    } else {
                                        Text("No AQI data")
                                            .foregroundColor(.gray)
                                    }
                                }
                                
                            case .failed:
                                Text("Failed to load air quality data")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                    }
                    
                    Section {
                        VStack(alignment: .leading) {
                            Text("Weather Radar Map(temperature)")
                                .font(.headline)
                            
                            switch viewModel.loadingState {
                            case .idle, .loading:
                                ProgressView("Loading map...")
                                    .frame(height: 200)
                            case .success:
                                if let currentWeather = viewModel.currentWeather {
                                    WeatherRadarMapView(
                                        apiKey: "f80b68e19449d82e57f76db8c28315e0",
                                        centerCoordinate: CLLocationCoordinate2D(
                                            latitude: currentWeather.coord.lat,
                                            longitude: currentWeather.coord.lon
                                        )
                                    )
                                    .frame(height: 300)
                                    .cornerRadius(12)
                                    .shadow(radius: 4)
                                    .padding()
                                    
                                } else {
                                    Text("Location not available")
                                        .foregroundColor(.gray)
                                }
                            case .failed:
                                Text("Failed to load map")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                    }
                    
                    Section {
                        VStack(alignment: .leading) {
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
                    .padding()
                }
            }
            .navigationTitle("Weather App ")
        }
        .task {
            await viewModel.fetchAllWeatherDataConcurrently()
        }
    }
}

#Preview {
    ContentView()
}

