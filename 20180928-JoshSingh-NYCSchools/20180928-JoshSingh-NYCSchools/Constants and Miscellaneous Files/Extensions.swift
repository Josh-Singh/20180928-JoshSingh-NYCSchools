//
//  Extensions.swift
//  20180928-JoshSingh-NYCSchools
//
//  Created by @mit on 29/09/18.
//  Copyright © 2018 Yash Singh. All rights reserved.
//

import UIKit

extension UIViewController {
    //Alert view for indicating errors
    func alertView(message: String){
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}
