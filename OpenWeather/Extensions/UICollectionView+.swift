import UIKit

extension UICollectionView {
    
    func register(identifier: String,
                  bundle: Bundle = Bundle.main) {
        
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func register(kind: String,
                  identifier: String,
                  bundle: Bundle = Bundle.main) {
        
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }
}
