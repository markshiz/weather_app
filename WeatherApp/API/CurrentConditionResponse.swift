import Foundation

struct Coordinate: Equatable {
    let lat: Double
    let lon: Double
}

struct MainConditions: Equatable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
}

struct CurrentConditionResponse: Equatable {
    let coord: Coordinate
    let main: MainConditions
    let name: String
}
