import Foundation

struct ForecastWeather: Codable {
    let list: [ForecastEntry]

    struct ForecastEntry: Codable, Identifiable {
        var id: Int { dt } // So for ForEach 
        let dt: Int
        let dt_txt: String
        let main: Main

        struct Main: Codable {
            let temp: Double
        }
    }
}
