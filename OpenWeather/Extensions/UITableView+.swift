import UIKit

extension UITableView {
    
    func register(identifier: String,
                  bundle: Bundle = Bundle.main) {
        
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: identifier)
    }
}
