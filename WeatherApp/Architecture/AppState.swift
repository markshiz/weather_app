import Foundation
import CoreLocation
import SwiftUI

struct DailyWeather: Equatable {
    let uuid: UUID = UUID()
    let image: Image
    let condition: String
    let hiTemp: String
    let lowTemp: String
}

struct AppState: Equatable {
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        if lhs.temperatureDegrees == rhs.temperatureDegrees,
           lhs.locationCoordinate.latitude == rhs.locationCoordinate.latitude,
           lhs.locationCoordinate.longitude == rhs.locationCoordinate.longitude,
           lhs.locationName == rhs.locationName,
           lhs.condition == rhs.condition,
           lhs.conditionImage == rhs.conditionImage,
           lhs.dailyWeather == rhs.dailyWeather,
           lhs.searchQuery == rhs.searchQuery {
            return true
        }
        return false
    }
    
    var temperatureDegrees: String
    var locationCoordinate: CLLocationCoordinate2D
    var locationName: String
    var condition: String
    var conditionImage: Image
    var dailyWeather: [DailyWeather]
    var searchQuery: String
    var query: QueryParser.ResultType
    
    init() {
        self.temperatureDegrees = "-- °F"
        self.locationCoordinate = Constants.START_LOCATION
        self.locationName = "Unknown Location"
        self.condition = "Unknown Condition"
        self.conditionImage = Constants.DEFAULT_WEATHER_IMAGE
        self.dailyWeather = []
        self.searchQuery = ""
        self.query = .unrecognized
    }
}
