import XCTest
import CoreLocation
import SwiftUI

@testable import WeatherApp

class AppStateTests : XCTestCase {
    var testObject = AppState()
    var testObject2 = AppState()

    override func setUp() {
        testObject.condition = "condition"
        testObject.conditionImage = Image("")
        testObject.dailyWeather = []
        testObject.locationCoordinate = CLLocationCoordinate2D()
        testObject.locationName = "locationName"
        testObject.searchQuery = "searchQuery"
        testObject.query = .unrecognized
        testObject.showAlert = false
        
        testObject2 = testObject
    }
    
    func testConditionDifferent() {
        testObject2.condition = ""
        XCTAssertNotEqual(testObject, testObject2)
    }
    
    func testConditionImageDifferent() {
        testObject2.conditionImage = Image(systemName: "")
        XCTAssertNotEqual(testObject, testObject2)
    }
    
    func testDailyWeatherDifferent() {
        testObject2.dailyWeather = [DailyWeather(date: "date", tag: "tag", condition: "condition", hiTemp: "1", lowTemp: "2")]
        XCTAssertNotEqual(testObject, testObject2)
    }
    
    func testLocationCoordinateDifferent() {
        testObject2.locationCoordinate = CLLocationCoordinate2D(latitude: 1, longitude: 1)
        XCTAssertNotEqual(testObject, testObject2)
    }
    
    func testLocationNameDifferent() {
        testObject2.locationName = ""
        XCTAssertNotEqual(testObject, testObject2)
    }
    
    func testSearchQueryDifferent() {
        testObject2.searchQuery = ""
        XCTAssertNotEqual(testObject, testObject2)
    }
    
    func testQueryDifferent() {
        testObject2.query = .cityName("chicago")
        XCTAssertNotEqual(testObject, testObject2)
    }
    
    func testShowAlertDifferent() {
        testObject2.showAlert = true
        XCTAssertNotEqual(testObject, testObject2)
    }
}
