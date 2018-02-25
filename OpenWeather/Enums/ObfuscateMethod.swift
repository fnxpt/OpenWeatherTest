enum ObfuscateMethod {
    
    case unicode(factor: Int)
    case character(character: Character)
    case salt(salt: String)
}
