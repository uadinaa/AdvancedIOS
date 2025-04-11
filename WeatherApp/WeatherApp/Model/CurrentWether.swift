import Foundation

struct CurrentWeather: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    let coord: Coordinates
    
    struct Main: Decodable {
        let temp: Double
        let feels_like: Double
    }

    struct Weather: Decodable {
        let description: String
    }
    
    struct Coordinates: Codable {
        let lon: Double
        let lat: Double
    }
}
