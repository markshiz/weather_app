import XCTest

extension XCUIElement {
    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }

        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        typeText(deleteString)
    }
}

class WeatherAppUITests: XCTestCase {
    private let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testSearchChicago() throws {
        app.launch()

        enterText(string: "chicago")
        
        waitForTextToAppear(string: "Chicago")
        XCTAssertTrue(app.tables.cells.count > 0, "There should be weather details")
    }
    
    func testSearchParis() throws {
        app.launch()
        
        enterText(string: "paris")
        
        waitForTextToAppear(string: "Paris")
        XCTAssertTrue(app.tables.cells.count > 0, "There should be weather details")
    }

    func testQuerySavedBetweenLaunches() throws {
        let text = "save me"
        
        app.launch()
        enterText(string: text)
        app.launch()
        
        XCTAssertEqual(app.textFields.firstMatch.value as? String, text)
    }

    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    private func enterText(string: String) {
        let textField = app.textFields.firstMatch
        textField.tap()
        textField.clearText()
        textField.typeText(string)
    }
    
    private func waitForTextToAppear(string: String) {
        let label = app.staticTexts[string]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: label, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
}
