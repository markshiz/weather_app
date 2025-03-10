import XCTest

@testable import WeatherApp

enum TestError: Error {
    case missingFile
}

func TestCurrentConditionResponse() throws -> CurrentConditionResponse {
    let testBundle = Bundle(for: CurrentConditionResponseTests.self)
    guard let url = testBundle.url(forResource: "current_location", withExtension: "json") else { throw TestError.missingFile }
    let data = try Data(contentsOf: url)
    return try DefaultJSONDecoder().decode(CurrentConditionResponse.self, from: data)
}


class CurrentConditionResponseTests: XCTestCase {
    func testParsing() throws {
        let value = try TestCurrentConditionResponse()
        XCTAssertEqual(value.id, 1907296)
        XCTAssertEqual(value.coord.lat, 35.02)
        XCTAssertEqual(value.coord.lon, 139.01)
        XCTAssertEqual(value.dt, Date(timeIntervalSince1970: TimeInterval(1485792967)))
        XCTAssertEqual(value.main.temp, 285.514)
        XCTAssertEqual(value.main.tempMin, 285.514)
        XCTAssertEqual(value.main.tempMax, 285.514)
        XCTAssertEqual(value.name, "Tawarano")
        XCTAssertEqual(value.weather[0].main, "Clear")
        XCTAssertEqual(value.weather[0].icon, "01n")
        XCTAssertEqual(value.weather[0].description, "clear sky")
    }
}
