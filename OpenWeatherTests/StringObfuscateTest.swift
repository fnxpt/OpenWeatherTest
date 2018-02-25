import XCTest
@testable import OpenWeather

class StringObfuscateTest: XCTestCase {
    
    func testUnicode() {
        validateObfuscation(string: "Teste",
                            stringToValidate: "мэћќэ",
                            method: .unicode(factor: 1000))
    }
    
    func testCharacter() {
        validateObfuscation(string: "Teste",
                            stringToValidate: "84ç101ç115ç116ç101",
                            method: .character(character: "ç"))
    }
    
    func testSalt() {
        validateObfuscation(string: "Teste",
                            stringToValidate: "eW@@T",
                            method: .salt(salt: "1234"))
    }
    
    func validateObfuscation(string: String, stringToValidate: String, method: ObfuscateMethod) {
        let obfuscated = string.obfuscate(with: method)
        print(obfuscated)
        XCTAssertEqual(stringToValidate, obfuscated)
        
        let unobfuscated = obfuscated.unobfuscate(with: method)
        XCTAssertEqual(string, unobfuscated)
    }
}
