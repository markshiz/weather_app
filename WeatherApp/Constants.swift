import Foundation
import CoreLocation
import SwiftUI

class Constants {
    static let API_KEY = "cf002751564a4c78f5f7ed479f1b9ba3"
    static let START_LOCATION = CLLocationCoordinate2D(latitude: 38.732631, longitude: -90.279732)
    static let DEFAULT_WEATHER_IMAGE = Image("DefaultWeatherImage")
    static let SAMPLE_WEATHER = DailyWeather(image: Constants.DEFAULT_WEATHER_IMAGE, condition: "Unknown", hiTemp: "--° F", lowTemp: "--° F")
}
