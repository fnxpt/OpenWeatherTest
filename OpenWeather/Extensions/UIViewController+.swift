import UIKit

extension UIViewController {
    
    func show(error: Error) {
        
        show(message: error.localizedDescription)
    }
    
    func show(message: String, completion: (() -> Void)? = nil) {
        
        show(message: message,
             actions: [],
             cancelTitle: "OK",
             completion: completion)
    }
    
    func show(message: String? = nil,
              actions: [UIAlertAction],
              style: UIAlertControllerStyle = .alert,
              cancelTitle: String? = nil,
              completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: style)
        
        if let popover = alert.popoverPresentationController {
            
            popover.sourceRect = view.bounds
            popover.sourceView = view
            popover.permittedArrowDirections = .init(rawValue: 0)
        }
        
        actions.forEach {
            alert.addAction($0)
        }
        
        if let title = cancelTitle {
            let cancelButton = UIAlertAction(title: title,
                                             style: .cancel,
                                             handler: { _ in
                                                guard let completion = completion else { return }
                                                
                                                completion()
            })
            alert.addAction(cancelButton)
        }
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
