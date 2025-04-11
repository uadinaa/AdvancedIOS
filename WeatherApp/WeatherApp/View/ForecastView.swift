import SwiftUI

struct ForecastView: View {
    let forecastList: [ForecastWeather.ForecastEntry]
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    // Group forecast by date
    var groupedForecast: [String: [ForecastWeather.ForecastEntry]] {
        Dictionary(grouping: forecastList) { entry in
            String(entry.dt_txt.prefix(10))  // Extract date part (yyyy-MM-dd)
        }
    }

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(groupedForecast.keys.sorted(), id: \.self) { date in
                    VStack(alignment: .leading) {
                        Text("Date: \(date)")
                            .font(.headline)
                        
                        // Pick the first entry of the day
                        if let entry = groupedForecast[date]?.first {
                            Text("Temperature: \(entry.main.temp, specifier: "%.1f")°C")
                                .font(.subheadline)
                        }
                    }
                    .frame(width: 200, height: 100)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.bottom, 5)
                }
            }
            .padding()
        }
    }
}
