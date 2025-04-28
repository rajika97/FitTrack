import XCTest

final class FitTrackUITests: XCTestCase {

    func testTabNavigation() {
        let app = XCUIApplication()
        app.launch()
        
        // Navigate to Workouts Tab
        app.tabBars.buttons["Workouts"].tap()
        XCTAssertTrue(app.staticTexts["Past Sessions"].exists)
        
        // Navigate to Goals Tab
        app.tabBars.buttons["Goals"].tap()
        XCTAssertTrue(app.staticTexts["Current Daily Step Goal:"].exists)
        
        // Navigate to Profile Tab
        app.tabBars.buttons["Profile"].tap()
        XCTAssertTrue(app.staticTexts["Profile"].exists)
    }
}
