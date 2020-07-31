import XCTest
import CombineExpectations
import ComposableArchitecture
import Combine

@testable import WeatherApp

class WeatherClientTests: XCTestCase {
    let testObject = WeatherClient()
    
    func testForecastCitySearch() throws {
        let recorder = try testEffect(effect: testObject.forecast(query: .cityName("saint louis")))
        let elements = try recorder.elements.get()
        XCTAssertTrue(elements[0].list.count > 0)
    }

    func testForecastZipSearch() throws {
        let recorder = try testEffect(effect: testObject.forecast(query: .zipCode("63109")))
        let elements = try recorder.elements.get()
        XCTAssertTrue(elements[0].list.count > 0)
    }
    
    func testForecastLatLongSearch() throws {
        let recorder = try testEffect(effect: testObject.forecast(query: .latitudeLongitude(38, -90)))
        let elements = try recorder.elements.get()
        XCTAssertTrue(elements[0].list.count > 0)
    }
    
    func testForecastCityStateSearch() throws {
        let recorder = try testEffect(effect: testObject.forecast(query: .cityAndState("chicago", "illinois")))
        let elements = try recorder.elements.get()
        XCTAssertTrue(elements[0].list.count > 0)
    }

    private func testEffect<D : Decodable, E : Error>(effect: Effect<D, E>) throws -> Recorder<D, E> {
        let recorder = effect.record()
        let completion = try wait(for: recorder.completion, timeout: 5)
        if case let .failure(error) = completion {
            XCTFail("Unexpected error \(error)")
        }
        return recorder
    }
    
}
