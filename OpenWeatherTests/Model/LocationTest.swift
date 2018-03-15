import XCTest
@testable import OpenWeather

class ForecastTest: XCTestCase {
    
    func testCSVInit() {
        
        let csv = "1519225200.0;8.36;overcast clouds;804;"
        
        do {
            let item = try Forecast(csv: csv)
            
            let date = Date(timeIntervalSince1970: 1519225200.0)
            
            XCTAssertEqual(item.code, 804)
            XCTAssertEqual(item.date, date)
            XCTAssertEqual(item.weather, "overcast clouds")
            XCTAssertEqual(item.temp, 8.36)
        } catch {
            
            XCTFail(error.localizedDescription)
        }
    }
}
