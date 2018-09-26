//
//  MGAlertController.swift
//  MGAlertController
//
//  Created by Mayur G on 25/09/18.
//  Copyright © 2018 Mayur G. All rights reserved.
//

/**
 An object that displays an alert message to the user.
 - You can use it globally
 - It can present mutiple alerts in stack order
 */
public class MGAlertController: UIAlertController {
    
    /// current holding window of presented alert controller
    private var alertWindow: AlertWindow?
    
    
    // MARK:- Convenience APIS
    
    /**
     Creates and returns a view controller for displaying an alert to the user.
     
     - parameter title: The title of the alert. Use this string to get the user’s attention and communicate the reason for the alert.
     - parameter message: Descriptive text that provides additional details about the reason for the alert.
     */
    public convenience init(title: String? = nil, message: String? = nil) {
        self.init(title: title, message: message, preferredStyle: .alert)
    }
    
    /**
     Attaches an action object to the alert or action sheet.
     
     - parameter title: The text to use for the button title. The value you specify should be localized for the user’s current language. This parameter must not be nil, except in a tvOS app where a nil title may be used with UIAlertAction.Style.cancel.
     - parameter style: Additional styling information to apply to the button. Use the style information to convey the type of action that is performed by the button. For a list of possible values, see the constants in UIAlertAction.Style.
     - parameter handler: A block to execute when the user selects the action. This block has no return value and takes the selected action object as its only parameter.
     */
    @discardableResult public func addAction(title: String,
                                             style: UIAlertAction.Style = .cancel,
                                             handler: ((UIAlertAction)->Void)? = nil) -> UIAlertAction
    {
        let buttonAction = UIAlertAction(title: title, style: style, handler: handler)
        addAction(buttonAction)
        return buttonAction
    }
    
    /**
     To show an alert controller globally.
     
     - parameter animated: Pass true to animate the presentation; otherwise, pass false. default value is true.
     */
    public func show(animated: Bool = true) {
        
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                self.show(animated: animated)
            }
            return
        }
        
        let blankViewController = UIViewController()
        blankViewController.view.backgroundColor = UIColor.clear
        
        let window = AlertWindow(frame: UIScreen.main.bounds)
        window.rootViewController = blankViewController
        window.backgroundColor = UIColor.clear
        window.windowLevel = UIWindow.Level(UIWindowLevelAlert + 1)
        window.makeKeyAndVisible()
        alertWindow = window
        
        blankViewController.present(self, animated: animated)
    }
    
}

/**
 A window which is visible only while that has become key.
 */
private class AlertWindow: UIWindow {
    
    override func becomeKey() {
        super.becomeKey()
        alpha = 1.0
    }
    
    override func resignKey() {
        super.resignKey()
        alpha = 0.0
    }
    
}
