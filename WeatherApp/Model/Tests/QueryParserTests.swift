import XCTest
@testable import WeatherApp

class QueryParserTests: XCTestCase {
    let testObject = QueryParser()
    
    func testWhitespace() {
        let result = testObject.parse(term: "         ")
        XCTAssertEqual(result, .unrecognized)
    }
    
    func testGarbage() {
        let result = testObject.parse(term: "=;.;;;;;;")
        XCTAssertEqual(result, .unrecognized)
    }

    func testGarbageWithSpaces() {
        let result = testObject.parse(term: "=;.  ;;;;;;  ")
        XCTAssertEqual(result, .unrecognized)
    }
    
    func testZipcode5() {
        let result = testObject.parse(term: "63109")
        XCTAssertEqual(result, .zipCode("63109"))
    }
    
    func testZipcode10() {
        let result = testObject.parse(term: "63136-3980")
        XCTAssertEqual(result, .zipCode("63136-3980"))
    }
    
    func testZipcode10NoDash() {
        let result = testObject.parse(term: "631363980")
        XCTAssertEqual(result, .zipCode("631363980"))
    }
    
    func testLatitudeLongitude() {
        let result = testObject.parse(term: "38, -90")
        XCTAssertEqual(result, .latitudeLongitude(38, -90))
    }
    
    func testLatitudeLongitude2() {
        let result = testObject.parse(term: "(38, -90)")
        XCTAssertEqual(result, .latitudeLongitude(38, -90))
    }
    func testLatitudeLongitude3() {
        let result = testObject.parse(term: "(38.5, -90.4)")
        XCTAssertEqual(result, .latitudeLongitude(38.5, -90.4))
    }
    
    func testCity() {
        let result = testObject.parse(term: "Chicago")
        XCTAssertEqual(result, .cityName("Chicago"))
    }
    
    func testCityAndState() {
        let result = testObject.parse(term: "Chicago, IL")
        XCTAssertEqual(result, .cityAndState("Chicago", "Illinois"))
    }
    
    func testCityAndState2() {
        let result = testObject.parse(term: "St Louis, MO")
        XCTAssertEqual(result, .cityAndState("St Louis", "Missouri"))
    }
    
    func testCityAndState3() {
        let result = testObject.parse(term: "St. Louis, MO")
        XCTAssertEqual(result, .cityAndState("St. Louis", "Missouri"))
    }
    
    func testCityAndState4() {
        let result = testObject.parse(term: "Chicago, Illinois")
        XCTAssertEqual(result, .cityAndState("Chicago", "Illinois"))
    }

}
