import XCTest

class OpenWeatherUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testExample() {
        
    }
    
}
