import CoreLocation

class ForecastRequest: ForecastProtocol, Requestable {
    
    static var service: String = "forecast"
    
    static func getForecast(coordinates: CLLocationCoordinate2D?,
                            completionHandler: @escaping (Response<Weather>) -> Void) {
        
        let location = coordinates ?? CLLocationCoordinate2D(latitude: 51.509865,
                                                             longitude: -0.118092)
        
        let parameters = ["lat": "\(location.latitude)",
                          "lon": "\(location.longitude)"]
        
        self.request(path: service,
                     parameters: parameters,
                     completionHandler: completionHandler)
    }
}
