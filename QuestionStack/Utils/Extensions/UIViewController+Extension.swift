//
//  UIViewController+Extension.swift
//  QuestionStack
//
//  Created by Taha Turan on 20.01.2024.
//

import UIKit

extension UIViewController {
    var screenWidth: CGFloat {
        return view.frame.size.width
    }
    var screenHeight: CGFloat {
        return view.frame.size.height
    }
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
            completion?()
        }))
        self.present(alertController, animated: true)
    }
}
