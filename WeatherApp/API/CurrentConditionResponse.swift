import Foundation

struct Coordinate: Equatable, Decodable {
    let lat: Double
    let lon: Double
}

struct MainConditions: Equatable, Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
}

struct WeatherConditions: Equatable, Decodable {
    let main: String
    let description: String
    let icon: String
}

struct CurrentConditionResponse: Equatable, Decodable {
    let coord: Coordinate
    let main: MainConditions
    let name: String
    let weather: [WeatherConditions]
}
