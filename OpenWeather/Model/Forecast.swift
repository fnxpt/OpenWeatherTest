import CoreLocation

class Forecast: Decodable {
    
    var date: Date!
    var temp: Double!
    var weather: String?
    var code: Int?
    
    private enum JSONKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
        
        //swiftlint:disable:next nesting
        enum Main: String, CodingKey {
            case temp
        }
        
        //swiftlint:disable:next nesting
        enum Weather: String, CodingKey {
            case code = "id"
            case desc = "description"
        }
        
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: JSONKeys.self)
        
        let timestamp = try container.decode(TimeInterval.self, forKey: .date)
        date = Date(timeIntervalSince1970: timestamp)
        
        let mainContainer = try container.nestedContainer(keyedBy: JSONKeys.Main.self, forKey: .main)
        temp = try mainContainer.decode(Double.self, forKey: .temp)
        
        var tempContainer = try container.nestedUnkeyedContainer(forKey: .weather)
        
        if !tempContainer.isAtEnd {
            let weatherContainer = try tempContainer.nestedContainer(keyedBy: JSONKeys.Weather.self)
            weather = try weatherContainer.decode(String.self, forKey: .desc)
            code = try weatherContainer.decode(Int.self, forKey: .code)
        }
        
//        debugPrint("\(timestamp);\(temp!);\(weather ?? "");\(code ?? 0);")
    }
    
    init(csv: String) throws {
        let parts = csv.split(separator: ";")
        
        if parts.count != 4 {
            throw ServiceError.unableToParse
        }
        
        let timestamp = TimeInterval(parts[0]) ?? 0
        date = Date(timeIntervalSince1970: timestamp)
        
        temp = Double(parts[1])
        weather = String(parts[2])
        code = Int(parts[3])
    }
}
