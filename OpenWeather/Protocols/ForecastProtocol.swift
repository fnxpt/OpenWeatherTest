import CoreLocation

protocol ForecastProtocol {
    static func getForecast(coordinates: CLLocationCoordinate2D?,
                            completionHandler: @escaping (Response<Weather>) -> Void)
}
