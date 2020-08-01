import Foundation
import CoreLocation
import SwiftUI

struct DailyWeather: Equatable {
    let date: String
    let tag: String
    let condition: String
    let hiTemp: String
    let lowTemp: String
}

extension DailyWeather {
    init(forecast: ForecastListItem) {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("EEE hh a")
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
        self.date = df.string(from: forecast.dt)
        self.tag = forecast.weather[0].icon
        self.condition = forecast.weather[0].main
        self.hiTemp = KelvinToFarenheight(value: forecast.main.tempMax)
        self.lowTemp = KelvinToFarenheight(value: forecast.main.tempMin)
    }
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
           lhs.searchQuery == rhs.searchQuery,
           lhs.showAlert == rhs.showAlert {
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
    var showAlert: Bool

    init() {
        self.temperatureDegrees = ""
        self.locationCoordinate = Constants.START_LOCATION
        self.locationName = ""
        self.condition = ""
        self.conditionImage = Constants.DEFAULT_WEATHER_IMAGE
        self.dailyWeather = []
        self.searchQuery = PersistedState().query ?? "saint louis, mo"
        self.query = .unrecognized
        self.showAlert = false
    }
}
