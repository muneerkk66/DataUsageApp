//
//  BaseVC.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 05/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showAlert(_ title: String? =  nil,
                   _ message: String? = nil){
        DispatchQueue.main.async { [weak self]() -> Void in
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: UIAlertController.Style.alert)
            self?.present(alert, animated: true, completion: nil)
        }
    }

}
