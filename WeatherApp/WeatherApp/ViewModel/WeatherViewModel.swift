import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather?
    @Published var loadingState: LoadingState = .idle
    @Published var errorMessage: String?
    
    @Published var forecast: ForecastWeather?
    @Published var forecastState: LoadingState = .idle
    
    @Published var airQuality: AirQuality?
    @Published var airState: LoadingState = .idle

    @Published var weatherAlerts: [WeatherAlert] = []

    let apiKey = "here you are gonna put your api"
    let city = "ur city"

    enum LoadingState {
        case idle, loading, success, failed
    }

    func fetchCurrentWeather() async {
        loadingState = .loading
        errorMessage = nil

        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Almaty&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else {
            loadingState = .failed
            errorMessage = "Invalid URL"
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            do {
                let decoded = try JSONDecoder().decode(CurrentWeather.self, from: data)
                self.currentWeather = decoded
                loadingState = .success
            } catch {
                print("CurrentWeather JSON:\n", String(data: data, encoding: .utf8) ?? "Invalid JSON")
                throw error
            }
        } catch {
            loadingState = .failed
            errorMessage = "Failed to load weather: \(error.localizedDescription)"
        }

    }
    
    func fetchForecast() async {
        airState = .loading
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=Almaty&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else {
            forecastState = .failed
            errorMessage = "Invalid URL"
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(ForecastWeather.self, from: data)
            self.forecast = decoded
            forecastState = .success
        } catch {
            forecastState = .failed
        }
        
        print("Forecast loaded with \(forecast?.list.count) entries")

    }
    
    private func fetchAirQualityData(lat: Double, lon: Double) async throws {
        guard let coordinates = currentWeather?.coord else {
            throw NSError(domain: "Missing coordinates from current weather", code: 0)
        }
        airState = .loading
        
        let urlString = "https://api.openweathermap.org/data/2.5/air_pollution?lat=43.25&lon=76.95&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            airState = .failed
            errorMessage = "Invalid URL"
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(AirQuality.self, from: data)
            self.airQuality = decoded
            airState = .success
            print("Air quality data: \(data)") // for debug
        } catch {
            airState = .failed
        }
    }
    
    
//    func fetchAllWeatherDataConcurrently() async {
//        await withTaskGroup(of: Void.self) { group in
//            group.addTask { await self.fetchCurrentWeather() }
//            group.addTask { await self.fetchForecast() }
//            group.addTask { await self.fetchAirQualityData(lat: lat, lon: lon) }
//        }
//    }
    func fetchAllWeatherDataConcurrently() async {
        do {
            async let currentWeatherTask = try fetchCurrentWeather()
            async let forecastTask = try fetchForecast()

            try await currentWeatherTask // Wait for currentWeather before fetching air quality

            if let coordinate = currentWeather?.coord {
                async let airQualityTask = try fetchAirQualityData(lat: coordinate.lat, lon: coordinate.lon)
                try await (forecastTask, airQualityTask)
            } else {
                print("No coordinates found for air quality fetch.")
            }

        } catch {
            print("Error in concurrent fetch: \(error)")
        }
    }
    
    func fetchWeatherAlerts(lat: Double, lon: Double) {
            guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=hourly,daily&appid=\(apiKey)") else {
                print("Invalid URL")
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error fetching weather alerts: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.weatherAlerts = decodedResponse.alerts ?? []
                    }

                } catch {
                    print("Error decoding weather alerts: \(error)")
                }
            }.resume()
        }
    func fetchWeatherAlerts(lat: Double, lon: Double) async {
            guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=hourly,daily&appid=\(apiKey)") else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                self.weatherAlerts = decodedResponse.alerts ?? []
            } catch {
                print("Error fetching or decoding weather alerts: \(error.localizedDescription)")
            }
        }
    
}


struct WeatherResponse: Codable {
    let alerts: [WeatherAlert]?
}
