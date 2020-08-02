import XCTest

@testable import WeatherApp

class URLComponentsFactoryTests: XCTestCase {

    let testObject = URLComponentsFactory()
    
    func testParsingCityAndStateForecast() throws {
        let comps = testObject.create(query: .cityAndState("chicago", "il"), endpoint: .forecast)
        XCTAssertEqual(comps?.url?.absoluteString, "https://api.openweathermap.org/data/2.5/forecast?q=chicago,%20il&appid=\(Constants.API_KEY)")
    }
    
    func testParsingCityForecast() throws {
        let comps = testObject.create(query: .cityName("chicago"), endpoint: .forecast)
        XCTAssertEqual(comps?.url?.absoluteString, "https://api.openweathermap.org/data/2.5/forecast?q=chicago&appid=\(Constants.API_KEY)")
    }
    
    func testParsingLatLongForecast() throws {
        let comps = testObject.create(query: .latitudeLongitude(-38, 90), endpoint: .forecast)
        XCTAssertEqual(comps?.url?.absoluteString, "https://api.openweathermap.org/data/2.5/forecast?lat=-38.0&lon=90.0&appid=\(Constants.API_KEY)")
    }
    
    func testParsingZipForecast() throws {
        let comps = testObject.create(query: .zipCode("63109"), endpoint: .forecast)
        XCTAssertEqual(comps?.url?.absoluteString, "https://api.openweathermap.org/data/2.5/forecast?zip=63109,us&appid=\(Constants.API_KEY)")
    }
    
    func testUnrecognizedForecast() throws {
        XCTAssertNil(testObject.create(query: .unrecognized, endpoint: .forecast))
    }
    
    func testParsingCityAndStateWeather() throws {
        let comps = testObject.create(query: .cityAndState("chicago", "il"), endpoint: .weather)
        XCTAssertEqual(comps?.url?.absoluteString, "https://api.openweathermap.org/data/2.5/weather?q=chicago,%20il&appid=\(Constants.API_KEY)")
    }
    
    func testParsingCityWeather() throws {
        let comps = testObject.create(query: .cityName("chicago"), endpoint: .weather)
        XCTAssertEqual(comps?.url?.absoluteString, "https://api.openweathermap.org/data/2.5/weather?q=chicago&appid=\(Constants.API_KEY)")
    }
    
    func testParsingLatLongWeather() throws {
        let comps = testObject.create(query: .latitudeLongitude(-38, 90), endpoint: .weather)
        XCTAssertEqual(comps?.url?.absoluteString, "https://api.openweathermap.org/data/2.5/weather?lat=-38.0&lon=90.0&appid=\(Constants.API_KEY)")
    }
    
    func testParsingZipWeather() throws {
        let comps = testObject.create(query: .zipCode("63109"), endpoint: .weather)
        XCTAssertEqual(comps?.url?.absoluteString, "https://api.openweathermap.org/data/2.5/weather?zip=63109,us&appid=\(Constants.API_KEY)")
    }
    
    func testUnrecognizedWeather() throws {
        XCTAssertNil(testObject.create(query: .unrecognized, endpoint: .weather))
    }
    
}
