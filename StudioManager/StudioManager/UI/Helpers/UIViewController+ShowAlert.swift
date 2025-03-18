//
//  UIViewController+ShowAlert.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 18/10/2024.
//

import UIKit

extension UIViewController {
    
    private static var activeAlertController: UIAlertController?
    
    func showErrorDialog(title: String?, message: String?, cancelTitle: String?, actionTitle: String? = nil, retryCompletion: (() -> Void)? = nil) {
        if let activeAlert = UIViewController.activeAlertController {
            // Update the current alert dynamically
            activeAlert.title = title
            activeAlert.message = message
        } else {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            // Retry option
            if actionTitle != nil, retryCompletion != nil {
                let retryAction = UIAlertAction(title: actionTitle, style: .default) { _ in
                    retryCompletion?()
                }
                alertController.addAction(retryAction)
            }
            
            // Cancel option
            let cancelAction = UIAlertAction(title: cancelTitle, style: .destructive) { _ in
                UIViewController.activeAlertController = nil
            }
            alertController.addAction(cancelAction)
            
            UIViewController.activeAlertController = alertController
            self.present(alertController, animated: true)
        }
    }
    
    func showSuccessDialog(title: String?, message: String?) {
        if let activeAlert = UIViewController.activeAlertController {
            // Update the current alert dynamically
            activeAlert.title = title
            activeAlert.message = message
        } else {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                UIViewController.activeAlertController = nil
            }
            alertController.addAction(okAction)
            
            UIViewController.activeAlertController = alertController
            self.present(alertController, animated: true)
        }
    }
}
