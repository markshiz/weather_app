import XCTest

@testable import WeatherApp

class KelvinToFarenheightTests : XCTestCase {
    func testConversion() {
        XCTAssertEqual(KelvinToFarenheight(value: 295.372), "72 °F")
    }
    
    func testConversion2() {
        XCTAssertEqual(KelvinToFarenheight(value: 0), "-459 °F")
    }
}
