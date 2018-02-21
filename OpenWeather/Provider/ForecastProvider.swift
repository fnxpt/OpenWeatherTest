import CoreLocation
import UIKit

class ForecastProvider {
    var providers: [ForecastProviderProtocol]
    var selectedProviderIndex: Int = 0
    var cellType: UITableViewCell.Type = DayCell.self
    
    init(providers: [ForecastProviderProtocol]) {
        self.providers = providers
    }
}

extension ForecastProvider: ForecastProviderProtocol {
    
    var city: Location? {
        get {
            let selectedProvider = providers[selectedProviderIndex]
            return selectedProvider.city
        }
        set {
            
        }
    }
    
    var days: [String: [Forecast]] {
        get {
            let selectedProvider = providers[selectedProviderIndex]
            return selectedProvider.days
        }
        set {
            
        }
    }
    
    var title: String {
        let selectedProvider = providers[selectedProviderIndex]
        return selectedProvider.title
    }
    
    func load(coordinate: CLLocationCoordinate2D?,
              completion: @escaping (_ error: Error?) -> Void) {
        
        let selectedProvider = providers[selectedProviderIndex]
        
        selectedProvider.load(coordinate: coordinate) { error in
            
            DispatchQueue.main.async {
                
                completion(error)
            }
        }
    }
    
    func numberOfDays() -> Int {
        let selectedProvider = providers[selectedProviderIndex]
        return selectedProvider.numberOfDays()
    }
    
    func numberOfForecasts(for day: String) -> Int {
        
        let selectedProvider = providers[selectedProviderIndex]
        return selectedProvider.numberOfForecasts(for: day)
    }
    
    func forecast(for day: Int) -> [Forecast]? {
        
        let selectedProvider = providers[selectedProviderIndex]
        return selectedProvider.forecast(for: day)
    }
}
