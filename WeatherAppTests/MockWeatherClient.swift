import ComposableArchitecture
import SwiftUI

@testable import WeatherApp

class MockWeatherClient: WeatherClientProtocol {
    func weather(query: QueryParser.ResultType) -> Effect<CurrentConditionResponse, APIFailure> {
        return Effect(value: try! TestCurrentConditionResponse())
    }
    
    func forecast(query: QueryParser.ResultType) -> Effect<ForecastResponse, APIFailure> {
        return Effect(value: try! TestForecastResponse())
    }
    
    func conditionImageFromTag(tag: String) -> Effect<Image, APIFailure> {
        return Effect(value: Constants.DEFAULT_WEATHER_IMAGE)
    }
}

class MockErrorWeatherClient: WeatherClientProtocol {
    func weather(query: QueryParser.ResultType) -> Effect<CurrentConditionResponse, APIFailure> {
        return Effect(error: .weatherClientFailure)
    }
    
    func forecast(query: QueryParser.ResultType) -> Effect<ForecastResponse, APIFailure> {
        return Effect(error: .weatherClientFailure)
    }
    
    func conditionImageFromTag(tag: String) -> Effect<Image, APIFailure> {
        return Effect(error: .imageFailure)
    }
}
