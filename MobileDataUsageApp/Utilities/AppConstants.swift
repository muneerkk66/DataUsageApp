//
//  AppConstants.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 04/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
class AppConstants: NSObject {
    
    //MARK:- URL & API details
     enum BaseURL:String {
           case production         = "https://data.gov.sg"
          // case test             = "http://data.gov.sg
    }
    enum APIUrls:String {
        case dataUsage           = "/api/action/datastore_search"
    }
    
    
    //MARK:- Pointed Server
    static let baseURL             =  BaseURL.production.rawValue
    
    
    //MARK:- Device Constants
    static let screenHeight        = UIScreen.main.bounds.size.height
    static let screenWidth         = UIScreen.main.bounds.size.width

   
}
