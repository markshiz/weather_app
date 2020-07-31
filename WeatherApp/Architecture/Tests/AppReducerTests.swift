import XCTest
import ComposableArchitecture
import SwiftUI

@testable import WeatherApp

let TEST_SCHEDULER = DispatchQueue.testScheduler

class AppReducerTests: XCTestCase {
    let store = TestStore(
      initialState: AppState(),
      reducer: appReducer,
      environment: AppEnvironment(
        mainQueue: TEST_SCHEDULER.eraseToAnyScheduler(),
        weatherClient: MockWeatherClient()
      )
    )

    func testImage() {
        let image = Constants.DEFAULT_WEATHER_IMAGE
        
        store.assert(
            .send(.conditionImageChanged(.success(image))) {
                $0.conditionImage = image
            }
        )
    }
}
