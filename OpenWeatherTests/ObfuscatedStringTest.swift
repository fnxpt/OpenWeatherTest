import XCTest
@testable import OpenWeather

class ObfuscatedStringTest: XCTestCase {
    
    func testUnicodeObfuscation() {
        
        validateObfuscation(string: "Unicode",
                            method: .unicode(factor: 2000))
    }
    
    func testCharacterObfuscation() {
        
        validateObfuscation(string: "Character",
                            method: .unicode(factor: 2000))
    }
    
    func testSaltObfuscation() {
        
        validateObfuscation(string: "Salt",
                            method: .salt(salt: "asjdlajshjldaosh1213"))
    }
    
    func testComplexObfuscation() {
        validateObfuscation(string: "R!3kz?Rsp3#RjFsL",
                            method: .salt(salt: "j21oujodsalndasi0dy90"))
    }
    
    func validateObfuscation(string: String, method: ObfuscateMethod) {
        let time: TimeInterval = 10
        let wrapper = ObfuscatedString(string: string, method: method, ttl: time)
        let unobfuscatedString = wrapper.get()
        //swiftlint:disable:next force_cast
        let copiedString = unobfuscatedString.copy() as! NSString
        
        XCTAssertEqual(string, String(unobfuscatedString), "strings should be equal")
        
        let expectation = self.expectation(description: "Wait for time to live ending")
        
        Timer.scheduledTimer(withTimeInterval: time, repeats: false) { _ in
            XCTAssertNotEqual(string, String(unobfuscatedString), "strings shouldn't be equal")
            XCTAssertEqual(string, String(copiedString), "strings should be equal")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: time + 10)
    }
}
