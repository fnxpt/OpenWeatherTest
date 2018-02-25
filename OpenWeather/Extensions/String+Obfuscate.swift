extension String {
    
    init(string: String, with method: ObfuscateMethod) {
        
        self = string.obfuscate(with: method)
    }
    
    func obfuscate(with method: ObfuscateMethod) -> String {
        
        switch method {
        case .unicode(let factor):
            return self.unicodeObfuscate(factor: factor)
        case .character(let character):
            return self.characterObfuscate(character: character)
        case .salt(let salt):
            return self.saltObfuscate(salt: salt)
        }
    }
    
    func unobfuscate(with method: ObfuscateMethod) -> String {
        
        switch method {
        case .unicode(let factor):
            return self.unicodeObfuscate(factor: factor * -1)
        case .character(let character):
            return self.characterUnObfuscate(character: character)
        case .salt(let salt):
            return self.saltObfuscate(salt: salt)
        }
    }
    
    private func saltObfuscate(salt: String) -> String {
        let text = [UInt8](self.utf8)
        let cipher = [UInt8](salt.utf8)
        let length = cipher.count
        
        let encrypted: [UInt8] = text.enumerated().map {
            return $0.element ^ cipher[$0.offset % length]
        }
        
        return String(bytes: encrypted, encoding: .utf8) ?? ""
    }
    
    private func unicodeObfuscate(factor: Int) -> String {
        return String(self.map {
            
            if let ascii = $0.unicodeScalars.first,
                Int(ascii.value) + factor > 0,
                let unicode = UnicodeScalar(Int(ascii.value) + factor) {
                return Character(unicode)
            }
            
            return $0
        })
    }
    
    private func characterObfuscate(character: Character) -> String {
        
        return String(self.enumerated().map {
            
            guard let ascii = $1.unicodeScalars.first else {
                return String($1)
            }
            
            let value = String(ascii.value)
            return $0 > 0 ? String(character) + value : value
            
            }.joined())
    }
    
    private func characterUnObfuscate(character: Character) -> String {
        let tmp = self.split(separator: character).map { string -> String in
            
            if let value = Int(string),
                let unicode = UnicodeScalar(value) {
                return String(Character(unicode))
            }
            return String(string)
        }
        
        return tmp.joined()
    }
}
