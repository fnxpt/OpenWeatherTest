import CoreLocation
import Foundation

class ForecastOnlineProvider: ForecastProviderProtocol {
    
    var title: String = "Online"
    var city: Location?
    var days: [String: [Forecast]] = [:]
    
    func load(coordinate: CLLocationCoordinate2D?,
              completion: @escaping (_ error: Error?) -> Void) {
        city = nil
        days = [:]
        
        ForecastRequest.getForecast(coordinates: coordinate) { response in
            
            switch response {
            case .error(let error):
                completion(error)
            case .success(let weather):
                self.city = weather.city
                self.days = weather.forecast.sorted(by: { (forecast1, forecast2) -> Bool in
                    return forecast1.date.timeIntervalSince1970 < forecast2.date.timeIntervalSince1970
                }).reduce([String: [Forecast]]()) { dict, forecast in
                    
                    var dict = dict
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let day = dateFormatter.string(from: forecast.date)
                    
                    var value = dict[day]
                    
                    if value == nil {
                        value = []
                    }
                    
                    value?.append(forecast)
                    
                    dict[day] = value
                    return dict
                }
                
                completion(nil)
            }
        }
    }
}
