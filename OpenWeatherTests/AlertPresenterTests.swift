import XCTest
@testable import OpenWeather

class AlertPresenterTests: XCTestCase {
    
    var viewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = UIViewController()
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    override func tearDown() {
        super.tearDown()
        
        //FORCE THE ALERT TO BE DISMISSED
        viewController.presentedViewController?.dismiss(animated: false, completion: nil)
    }
    
    func testWithEverything() {
        
        let okAction = UIAlertAction(title: "Button 1",
                                     style: .default) { action in
                                        print("Button '\(action.title ?? "")' was pressed)")
        }
        
        let cancelAction = UIAlertAction(title: "Button 2",
                                         style: .cancel) { action in
                                            print("Button '\(action.title ?? "")' was pressed)")
        }
        
        show(title: "Test Title",
             message: "Test Message",
             buttons: [okAction, cancelAction])
    }
    
    func testWithoutTitle() {
        let okAction = UIAlertAction(title: "Button 1",
                                     style: .default) { action in
                                        print("Button '\(action.title ?? "")' was pressed)")
        }
        
        let cancelAction = UIAlertAction(title: "Button 2",
                                         style: .cancel) { action in
                                            print("Button '\(action.title ?? "")' was pressed)")
        }
        
        show(title: nil,
             message: "Test Message",
             buttons: [okAction, cancelAction])
    }
    
    func testWithoutMessage() {
        
        let okAction = UIAlertAction(title: "Button 1",
                                     style: .default) { action in
                                        print("Button '\(action.title ?? "")' was pressed)")
        }
        
        let cancelAction = UIAlertAction(title: "Button 2",
                                         style: .cancel) { action in
                                            print("Button '\(action.title ?? "")' was pressed)")
        }
        
        show(title: "Test Title",
             message: nil,
             buttons: [okAction, cancelAction])
    }
    
    func testWithoutActions() {
        
        show(title: "Test Title",
             message: "Test Message")
    }
    
    func testWithoutAnything() {

        show(title: nil,
             message: nil)
    }
    
    private func show(title: String?, message: String?, buttons: [UIAlertAction] = []) {
        
        let expectation = self.expectation(description: "Wait for Alert to be presented")
        
        let alertPresenter = AlertPresenter()
        
        alertPresenter.showAlert(from: viewController,
                                 title: title,
                                 message: message,
                                 actions: buttons,
                                 completion: {
                                    
                                    XCTAssertNotNil(self.viewController.presentedViewController,
                                                    "The presented viewcontroller shouldn't be nil")
                                    
                                    if let alert = self.viewController.presentedViewController as? UIAlertController {
                                        
                                        XCTAssertEqual(alert.title, title)
                                        XCTAssertEqual(alert.message, message)
                                        
                                        if buttons.count == 0 {
                                            
                                            XCTAssertEqual(alert.actions.count, 1)
                                        } else {
                                            
                                            XCTAssertEqual(alert.actions.count, buttons.count)
                                            
                                            for index in 0..<buttons.count {
                                                
                                                let button = buttons[index]
                                                let action = alert.actions[index]
                                                
                                                XCTAssertEqual(button.title, action.title,
                                                               "The button title should be the same")
                                                XCTAssertEqual(button.style, action.style,
                                                               "The button style should be the same")
                                            }
                                        }
                                    } else {
                                        XCTFail("The presented viewcontroller must be an UIAlertController")
                                    }

                                    expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
    }
}
