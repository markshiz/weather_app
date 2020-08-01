import XCTest
import ComposableArchitecture
import SwiftUI
import CoreLocation

@testable import WeatherApp

let TEST_SCHEDULER = DispatchQueue.testScheduler

class AppReducerTests: XCTestCase {
    func testSearchTermChanged() {
        let store = TestStore(
          initialState: AppState(),
          reducer: appReducer.debug(),
          environment: AppEnvironment(
            mainQueue: TEST_SCHEDULER.eraseToAnyScheduler(),
            weatherClient: MockWeatherClient()
          )
        )
        
        let query = "63109"
        let resp = try! TestCurrentConditionResponse()
        let resp2 = try! TestForecastResponse()
        let img = Constants.DEFAULT_WEATHER_IMAGE

        store.assert(
            .send(.searchTermChanged(query)) {
                $0.searchQuery = query
                $0.query = .zipCode(query)
            },
            .do { TEST_SCHEDULER.advance(by: 0.3) },
            .receive(.currentConditionResponse(.success(resp))) {
                $0.locationName = resp.name
                $0.condition = resp.weather[0].main
                $0.locationCoordinate = CLLocationCoordinate2D(latitude: resp.coord.lat, longitude: resp.coord.lon)
                $0.temperatureDegrees = KelvinToFarenheight(value: resp.main.temp)
            },
            .do { TEST_SCHEDULER.advance() },
            .receive(.conditionImageChanged(.success(img))) {
                $0.conditionImage = img
            },
            .receive(.forecastResponse(.success(resp2))) {
                $0.dailyWeather = resp2.list.map { item -> DailyWeather in
                    return DailyWeather(forecast: item)
                }
            }
        )
    }
    
    func testSearchTermChangedWithError() {
        let store = TestStore(
          initialState: AppState(),
          reducer: appReducer.debug(),
          environment: AppEnvironment(
            mainQueue: TEST_SCHEDULER.eraseToAnyScheduler(),
            weatherClient: MockErrorWeatherClient()
          )
        )
        
        let query = "63109"

        store.assert(
            .send(.searchTermChanged(query)) {
                $0.searchQuery = query
                $0.query = .zipCode(query)
            },
            .do { TEST_SCHEDULER.advance(by: 0.3) },
            .receive(.currentConditionResponse(.failure(.weatherClientBadResponse))) {
                $0.showAlert = true
            }
        )
    }
}
