//
//  UIViewController+ShowAlert.swift
//  StudioManager
//
//  Created by Dmytro Yaremyshyn on 18/10/2024.
//

import UIKit

extension UIViewController {

    func showErrorDialog(title: String?, message: String?, cancelTitle: String?, actionTitle: String? = nil, retryCompletion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Retry option
        if actionTitle != nil, retryCompletion != nil {
            let retryAction = UIAlertAction(title: actionTitle, style: .default) { _ in
                retryCompletion?()
            }
            alertController.addAction(retryAction)
        }
        
        // Cancel option
        let cancelAction = UIAlertAction(title: cancelTitle, style: .destructive)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
}
