//
//  NetworkManager.swift
//  MobileDataUsageApp
//
//  Created by x218507 on 04/04/20.
//  Copyright © 2020 Muneer. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

private typealias APICalls = NetworkManager

class NetworkManager: NSObject {
    
    var baseURL = AppConstants.baseURL
    internal typealias ApiCompletionBlock = (_ responseObject : AnyObject?, _ errorObject : NSError?) -> ()
        
}

extension APICalls {
    //MARK:- Makes a GET Request
    /**
     - Parameter url: The url to fetch the data
     - Parameter parameters: The JSON data that has to be sent
     - Parameter completionBlock: Block that says whether the request was successful or failure
     
     */
       func getRequestPath(url:String, parameters:[String:AnyObject]?, completionBlock:@escaping ApiCompletionBlock) {
     
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers:nil)
            .responseJSON {(response) -> Void in
                
                switch (response.result){
                    case .success(_):
                            /* to check versonError in result*/
                            completionBlock(response.data as AnyObject?, nil)
                    case .failure(let error):
                            completionBlock(nil, error as NSError? )
                }
                
               
        }
    }

    
}
