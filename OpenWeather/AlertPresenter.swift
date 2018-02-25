import UIKit

class AlertPresenter {
    
    func showAlert(from viewController: UIViewController,
                   title: String? = nil,
                   message: String? = nil,
                   actions: [UIAlertAction] = [],
                   completion: (() -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if actions.count > 0 {
            actions.forEach {
                alert.addAction($0)
            }
        } else {
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
        }
        
        DispatchQueue.main.async {

            viewController.present(alert, animated: false) {

                completion?()
            }
        }
    }
}
