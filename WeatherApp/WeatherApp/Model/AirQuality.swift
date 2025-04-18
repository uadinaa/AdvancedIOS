import Foundation

struct AirQuality: Codable {
    let list: [AQEntry]

    struct AQEntry: Codable {
        let main: Main
        let components: Components

        struct Main: Codable {
            let aqi: Int
        }

        struct Components: Codable {
            let co: Double
            let no: Double
            let no2: Double
            let o3: Double
            let so2: Double
            let pm2_5: Double
            let pm10: Double
            let nh3: Double
        }
    }
}
