import UIKit
import MapKit
import CoreLocation

class CityHeader: UIView {
    
    @IBOutlet weak private var mapView: MKMapView!
    @IBOutlet weak private var locationLabel: UILabel!
    
    var coordinate: CLLocationCoordinate2D {
        return mapView.userLocation.coordinate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
}

extension CityHeader: Updatable {
    
    func update(model: Any?) {
        if let model = model as? Location {
            
            DispatchQueue.main.async {
                self.locationLabel.text = "\(model.name ?? ""), \(model.country ?? "")"
                
                if let coordinates = model.coordinates {
                    self.mapView.centerCoordinate = coordinates
                }
            }
        }
    }
}

extension CityHeader: Resetable {
    
    func reset() {
        locationLabel.text = nil
    }
}
