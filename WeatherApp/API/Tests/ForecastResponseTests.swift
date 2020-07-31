import XCTest

@testable import WeatherApp

func TestForecastResponse() throws -> ForecastResponse {
    let testBundle = Bundle(for: ForecastResponseTests.self)
    guard let url = testBundle.url(forResource: "forecast", withExtension: "json") else { throw TestError.missingFile }
    let data = try Data(contentsOf: url)
    return try DefaultJSONDecoder().decode(ForecastResponse.self, from: data)
}

class ForecastResponseTests: XCTestCase {
    func testParsing() throws {
        let value = try TestForecastResponse()
        XCTAssertEqual(value.list.count, 40)
        XCTAssertEqual(value.list[0].main.temp, 261.45)
        XCTAssertEqual(value.list[0].main.tempMin, 259.086)
        XCTAssertEqual(value.list[0].main.tempMax, 261.45)
        XCTAssertEqual(value.list[0].weather[0].main, "Clear")
        XCTAssertEqual(value.list[0].weather[0].icon, "02n")
        XCTAssertEqual(value.list[0].weather[0].description, "clear sky")
    }
}
