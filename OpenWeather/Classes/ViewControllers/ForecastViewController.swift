import CoreLocation
import UIKit

class ForecastViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var headerView: CityHeader!
    @IBOutlet weak private var segmentedControl: UISegmentedControl!
    @IBOutlet weak private var activityIndicatorView: UIActivityIndicatorView!
    
    let presenter: ForecastProvider = ForecastProvider(providers: [ForecastOnlineProvider(),
                                                                     ForecastOfflineProvider()])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        localize()
        load()
    }
    
    func config() {
        
        activityIndicatorView.color = Palette.primary.color()
        tableView.register(identifier: presenter.cellType.className)
    }
    
    func load(coordinate: CLLocationCoordinate2D? = nil) {
        
        DispatchQueue.main.async {
            
            self.activityIndicatorView.isHidden = false
        }
        presenter.load(coordinate: coordinate) { error in
            
            if let error = error {
                
                self.show(message: error.localizedDescription)
            } else {
                
                self.headerView.update(model: self.presenter.city)
                self.tableView.reloadData()
            }
            
            self.activityIndicatorView.isHidden = true
        }
    }
    
    func localize() {
        title = "Forecast"
        
        segmentedControl.removeAllSegments()
        presenter.providers.forEach { 
            let title = $0.title
            let index = segmentedControl.numberOfSegments
            segmentedControl.insertSegment(withTitle: title, at: index, animated: false)
        }
        segmentedControl.selectedSegmentIndex = 0
        
    }
    
    @IBAction func didChangeSource(_ sender: Any) {
        
        presenter.selectedProviderIndex = segmentedControl.selectedSegmentIndex
        load()
    }
    
    @IBAction func getUserPosition(_ sender: Any) {
        
        let coordinate = headerView.coordinate
        
        if CLLocationCoordinate2DIsValid(coordinate) {
            load(coordinate: coordinate)
        } else {
            show(message: "The current location is not valid, check if you have allowed gps access")
        }
    }
}

extension ForecastViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.numberOfDays()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = presenter.cellType.className
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if let item = presenter.forecast(for: indexPath.item),
            let updatable = cell as? Updatable {
            
            updatable.update(model: item)
        }
        
        return cell
    }
}
