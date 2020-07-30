import XCTest
@testable import WeatherApp

class QueryParserTests: XCTestCase {
    let testObject = QueryParser()
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testWhitespace() {
        let result = testObject.parse(term: "         ")
        XCTAssertEqual(result, QueryParser.ResultType.unrecognized)
    }
    
    func testGarbage() {
        let result = testObject.parse(term: "=;.;;;;;;")
        XCTAssertEqual(result, QueryParser.ResultType.unrecognized)
    }

    func testGarbageWithSpaces() {
        let result = testObject.parse(term: "=;.  ;;;;;;  ")
        XCTAssertEqual(result, QueryParser.ResultType.unrecognized)
    }
    
    func testZipcode() {
        let result = testObject.parse(term: "63109")
        XCTAssertEqual(result, QueryParser.ResultType.zipCode("63109"))
    }
    
    func testLatitudeLongitude() {
        let result = testObject.parse(term: "38, -90")
        XCTAssertEqual(result, QueryParser.ResultType.latitudeLongitude(38, -90))
    }
    
    func testCity() {
        let result = testObject.parse(term: "Chicago")
        XCTAssertEqual(result, QueryParser.ResultType.cityName("Chicago"))
    }

    func testPerformanceExample() throws {
    }
}
