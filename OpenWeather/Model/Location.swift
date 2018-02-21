import CoreLocation

class Location: Decodable {
    
    var identifier: Int = 0
    var name: String!
    var coordinates: CLLocationCoordinate2D?
    var country: String!
    
    private enum JSONKeys: String, CodingKey {
        case identifier = "id"
        case name
        case country
        case coordinates = "coord"
        
        //swiftlint:disable:next nesting
        enum Coordinates: String, CodingKey {
            case latitude = "lat"
            case longitude = "lon"
        }
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: JSONKeys.self)
        
        identifier = try container.decode(Int.self, forKey: .identifier)
        name = try container.decode(String.self, forKey: .name)
        country = try container.decode(String.self, forKey: .country)

        let coordinateContainer = try container.nestedContainer(keyedBy: JSONKeys.Coordinates.self,
                                                                forKey: .coordinates)
        
        let latitude = try coordinateContainer.decode(Double.self, forKey: .latitude)
        let longitude = try coordinateContainer.decode(Double.self, forKey: .longitude)
        
        coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
//        debugPrint("\(identifier);\(name!);\(country ?? "");\(latitude);\(longitude);")
    }
    
    init(csv: String) throws {
        
        let parts = csv.split(separator: ";")
        
        if parts.count != 5 {
            throw ServiceError.unableToParse
        }
        
        identifier = Int(parts[0]) ?? 0
        name = String(parts[1])
        country = String(parts[1])
        
        if let latitude = Double(parts[3]),
            let longitude = Double(parts[4]) {
            
            coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
}
