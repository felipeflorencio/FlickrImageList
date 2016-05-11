//
//  APIConnection.swift
//  FlickrTest
//
//  Created by Felipe Florencio Garcia on 5/7/16.
//  Copyright © 2016 Felipe Florencio Garcia. All rights reserved.
//

import Foundation


// Our connection and request class totally dummy make request and pass response just this
class APIConnection: NSObject {
    
    typealias GetReturn = (success: NSData?, failure: NSError?) -> ()
    
    static func get(request: NSURLRequest, callback: GetReturn) {
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            if error == nil {
                callback(success: data, failure: nil)
            } else {
                callback(success: nil, failure: error)
            }
            
        }
        
        task.resume()
        
    }
    
}