//
//  EnviromentUtil.swift
//  FlickrTest
//
//  Created by Felipe Florencio Garcia on 5/7/16.
//  Copyright © 2016 Felipe Florencio Garcia. All rights reserved.
//

import Foundation

// Our enviroment data, its good to make easier manage 
struct EnviromentUtil {
    
    let FlickrKEY = "402a8c6debcf19f4997733b00d96a930"
    
    var environment: [String:AnyObject]? {
        get {
            return NSBundle.mainBundle().infoDictionary?["EnvironmentSetting"] as? [String:AnyObject]
        }
    }
    
    var baseUrl: String? {
        get {
            let baseUrl = environment?["BASE_URL"] as? String
            let urlWithKey = baseUrl! + FlickrKEY + "&format=json&nojsoncallback=1"
            return urlWithKey
        }
    }
    
}