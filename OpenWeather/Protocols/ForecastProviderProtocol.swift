import CoreLocation

protocol ForecastProviderProtocol {
    var title: String { get }
    var city: Location? { get set }
    var days: [String: [Forecast]] { get set }
    
    func load(coordinate: CLLocationCoordinate2D?,
              completion: @escaping (_ error: Error?) -> Void)
    func numberOfDays() -> Int
    func numberOfForecasts(for day: String) -> Int
    func forecast(for day: Int) -> [Forecast]?
}

extension ForecastProviderProtocol {
    
    func numberOfDays() -> Int {
        
        return days.count
    }
    
    func numberOfForecasts(for day: String) -> Int {
        
        return days[day]?.count ?? 0
    }
    
    func forecast(for day: Int) -> [Forecast]? {
        guard days.count > day else { return nil }
        
        let sortedArray = Array(days).sorted { (dict1, dict2) -> Bool in
            return dict1.key < dict2.key
        }
        let key = sortedArray[day].key
        
        return days[key]
    }
}
