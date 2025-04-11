import Foundation

struct WeatherAlert: Codable, Identifiable {
    let id: Int
    let senderName: String
    let event: String
    let start: Int
    let end: Int
    let description: String
}
