import CoreLocation
import Foundation

class ForecastOfflineProvider: ForecastProviderProtocol {
    
    var title: String = "Offline"
    var city: Location?
    var days: [String: [Forecast]] = [:]
    
    func load(coordinate: CLLocationCoordinate2D?,
              completion: @escaping (_ error: Error?) -> Void) {
        
        if let url = Bundle.main.url(forResource: "offline", withExtension: "csv") {
            do {
                let file = try String(contentsOf: url)
                let lines = file.split(separator: "\n")
                
                if let firstLine = lines.first {
                    
                    city = try Location(csv: String(firstLine))
                }
                let forecasts = try lines.dropFirst().map {
                    return try Forecast(csv: String($0))
                }
                
                self.days = forecasts.sorted(by: { (forecast1, forecast2) -> Bool in
                    return forecast1.date < forecast2.date
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
            } catch {
                completion(error)
            }   
        }
    }
}
