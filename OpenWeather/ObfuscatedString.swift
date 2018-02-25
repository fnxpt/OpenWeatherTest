import Foundation

class ObfuscatedString {
    
    private var obfuscated: String
    private var value: NSMutableString?
    private var method: ObfuscateMethod
    private var ttl: TimeInterval
    private var timer: Timer?
    
    init(string: String,
         method: ObfuscateMethod,
         ttl: TimeInterval = 30) {
        
        self.method = method
        self.ttl = ttl
        self.obfuscated = string.obfuscate(with: method)
    }
    
    func get() -> NSString {
        guard value == nil else { return value! }
        
        timer?.invalidate()
        self.value = NSMutableString(string: obfuscated.unobfuscate(with: method))
        
        timer = Timer.scheduledTimer(withTimeInterval: ttl,
                                     repeats: false) { timer in
                                        
                                        if let value = self.value {
                                            value.deleteCharacters(in: NSRange(location: 0,
                                                                               length: value.length))
                                        }
                                        self.value = nil
                                        self.timer = nil
        }
        return self.value!
    }
}
