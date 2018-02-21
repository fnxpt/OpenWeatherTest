class Weather: Decodable {
    
    var city: Location!
    var forecast: [Forecast]!
    
    private enum JSONKeys: String, CodingKey {
        case city
        case forecast = "list"
    }
    
    required init(from decoder: Decoder) throws {
    
        let container = try decoder.container(keyedBy: JSONKeys.self)
        city = try container.decodeIfPresent(Location.self, forKey: .city)
        forecast = try container.decodeIfPresent([Forecast].self, forKey: .forecast)
    }
}
