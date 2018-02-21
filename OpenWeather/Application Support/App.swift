import UIKit
import CoreLocation

class App {
    
    static let shared: App = App()
    var locationManager: CLLocationManager?
    
    private init() { }
    
    func didFinishLauching() {
        
        theme()
        requestPermissions()
    }
}

extension App {
    
    func theme() {
        
        let navAppearance = UINavigationBar.appearance()
        navAppearance.isTranslucent = true
        navAppearance.tintColor = Palette.secondary.color()
        navAppearance.barTintColor = Palette.primary.color()
        navAppearance.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: Palette.secondary.color()]
        
        if #available(iOS 11, *) {
            
            navAppearance.prefersLargeTitles = true
            navAppearance.largeTitleTextAttributes = [
                NSAttributedStringKey.foregroundColor: Palette.secondary.color(),
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 26)
            ]
        }
       
        UISegmentedControl.appearance().tintColor = Palette.secondary.color()
        UIActivityIndicatorView.appearance().tintColor = Palette.primary.color()
    }
    
    func requestPermissions() {
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
    }
}
