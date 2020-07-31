import Foundation

struct ForecastListItem: Equatable, Decodable {
    let main: MainConditions
    let weather: [WeatherConditions]
}

struct ForecastResponse: Equatable, Decodable {
    let list: [ForecastListItem]
}
